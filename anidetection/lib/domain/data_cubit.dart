import 'dart:io';

import 'package:anidetection/utils/my_tree_node.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../service/predict_service.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(EmptyDataState());

  Future<void> pickDirectory() async {
    String? selectedDirectoryPath =
        await FilePicker.platform.getDirectoryPath();
    if (selectedDirectoryPath != null) {
      Directory directory = Directory(selectedDirectoryPath);
      MyTreeNode directoryTree = await _buildDirectoryTree(directory);
      emit(DirectoryDataState(directoryTree));
    }
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

  void predictData() async {
    try {
      List<String> filePathes = (state as DirectoryDataState)
          .rootNode
          .children
          .map<String>((value) => value.title)
          .toList();

      filePathes = filePathes
          .where((el) => el.contains(".JPG") || el.contains(".jpg"))
          .toList();

      List<MultipartFile> mutiparts = filePathes
          .map<MultipartFile>((el) => MultipartFile.fromFileSync(el))
          .toList();

      emit(LoadingDataState());
      var result = await GetIt.I<PredictService>().predictData(mutiparts);
      debugPrint(result);
      emit(CsvDataState(result));
    } catch (e) {
      debugPrint("${e}");
      emit(ErrorDataState());
    }
  }
}
