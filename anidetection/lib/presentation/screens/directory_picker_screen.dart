import 'package:anidetection/service/predict_service.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:get_it/get_it.dart';

class DirectoryPickerPage extends StatefulWidget {
  const DirectoryPickerPage({super.key});

  @override
  _DirectoryPickerPageState createState() => _DirectoryPickerPageState();
}

class _DirectoryPickerPageState extends State<DirectoryPickerPage> {
  Directory? selectedDirectory;
  MyTreeNode? rootNode;
  late TreeController<MyTreeNode> _treeController;
  List<List<dynamic>>? data;

  @override
  void initState() {
    super.initState();
    _treeController = TreeController<MyTreeNode>(
      roots: [],
      childrenProvider: (MyTreeNode node) => node.children,
    );
  }

  void predictData() async {
    List<String> filePathes = rootNode?.children.map<String>((value) => value.title).toList() ?? [];

    filePathes = filePathes.where((el) => el.contains(".JPG") || el.contains(".jpg")).toList();

    List<MultipartFile> mutiparts = filePathes.map<MultipartFile>((el) => MultipartFile.fromFileSync(el)).toList();

    var result = await GetIt.I<PredictService>().predictData(mutiparts);
    debugPrint(result);
    setState(() {
      data = const CsvToListConverter().convert(result);
    });
  }

  Future<void> _pickDirectory() async {
    String? selectedDirectoryPath =
        await FilePicker.platform.getDirectoryPath();
    if (selectedDirectoryPath != null) {
      Directory directory = Directory(selectedDirectoryPath);
      MyTreeNode directoryTree = await _buildDirectoryTree(directory);
      setState(() {
        selectedDirectory = directory;
        rootNode = directoryTree;
        _treeController = TreeController<MyTreeNode>(
          roots: [rootNode!],
          childrenProvider: (MyTreeNode node) => node.children,
        );
      });
    }
    setState(() {
      data = null;
    });
  }

  Future<MyTreeNode> _buildDirectoryTree(Directory directory) async {
    List<MyTreeNode> children = [];
    try {
      await for (FileSystemEntity entity
          in directory.list(recursive: false, followLinks: false)) {
        if (entity is Directory) {
          MyTreeNode subDir = await _buildDirectoryTree(entity);
          children.add(subDir);
        } else if (entity is File) {
          children.add(MyTreeNode(title: entity.path.split('/').last));
        }
      }
    } catch (e) {
      print("Error reading directory: $e");
    }
    return MyTreeNode(
      title: directory.path.split("\\").last,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Detector"),
        actions: [
          ElevatedButton(
            onPressed: _pickDirectory,
            child: const Text('Pick Directory'),
          ),
          rootNode == null
              ? const SizedBox()
              : ElevatedButton(
              onPressed: () {predictData();}, child: const Text("Обработать"))
        ],
      ),
      body: data == null ? ListView(
        shrinkWrap: true,
        children: [
          rootNode != null
              ? Container(
            margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: AnimatedTreeView<MyTreeNode>(
                    shrinkWrap: true,
                    treeController: _treeController,
                    nodeBuilder:
                        (BuildContext context, TreeEntry<MyTreeNode> entry) {
                      return InkWell(
                        onTap: () =>
                            _treeController.toggleExpansion(entry.node),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TreeIndentation(
                            entry: entry,
                            child: Text(entry.node.title.split("\\").last),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text('No directory selected'),
                ),
        ],
      ) : SingleChildScrollView(
        child: Table(
          border: TableBorder.all(width: 1.0),
          children: data!.map((item) {
            return TableRow(
                children: item.map((row) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        row.toString(),
                      ),
                    ),
                  );
                }).toList());
          }).toList(),
        ),
      ),
    );
  }
}

class MyTreeNode {
  MyTreeNode({
    required this.title,
    this.children = const <MyTreeNode>[],
  });

  final String title;
  final List<MyTreeNode> children;
}
