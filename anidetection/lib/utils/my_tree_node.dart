class MyTreeNode {
  MyTreeNode({
    required this.title,
    this.children = const <MyTreeNode>[],
  });

  final String title;
  final List<MyTreeNode> children;
}