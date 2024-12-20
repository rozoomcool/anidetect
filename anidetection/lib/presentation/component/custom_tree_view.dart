import 'package:anidetection/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

import '../../utils/my_tree_node.dart';

class CustomTreeView extends StatefulWidget {
  const CustomTreeView({super.key, required this.rootNode});

  final MyTreeNode rootNode;

  @override
  State<CustomTreeView> createState() => _CustomTreeViewState();
}

class _CustomTreeViewState extends State<CustomTreeView> {
  late final TreeController<MyTreeNode> _treeController;

  @override
  void didUpdateWidget(covariant CustomTreeView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _treeController = TreeController<MyTreeNode>(
        roots: [widget.rootNode],
        childrenProvider: (MyTreeNode node) => node.children,
      );
    });
  }

  @override
  void dispose() {
    _treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTreeView<MyTreeNode>(
      shrinkWrap: true,
      treeController: _treeController,
      nodeBuilder: (BuildContext context, TreeEntry<MyTreeNode> entry) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GestureDetector(
            onTap: () => _treeController.toggleExpansion(entry.node),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TreeIndentation(
                entry: entry,
                child: Row(
                  children: [
                    Icon(
                      entry.node.children.isNotEmpty
                          ? Icons.folder
                          : isImageFile(entry.node.title)
                              ? Icons.image
                              : Icons.insert_drive_file,
                      color: entry.node.children.isNotEmpty
                          ? Colors.orange
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      entry.node.title.split("\\").last,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
