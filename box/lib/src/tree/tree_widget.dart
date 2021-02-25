import 'package:flutter/material.dart';

import 'node.dart';

class TreeWidget extends StatelessWidget {
  final Tree tree;

  static TextStyle style = TextStyle(
    fontSize: 20,
  );

  const TreeWidget({Key key, this.tree}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _buildNodeView(tree),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.edit),
        onPressed: () {},
      ),
    );
  }

  Widget _buildLabel(String label, Node node) => GestureDetector(
        child: Text(label, style: style),
        onTap: () {
          tree.move(node);
        },
      );

  Widget _buildNodeView(Node node) {
    if (node.name == null) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(node.name, node),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Column(
            children:
                node.children.map((child) => _buildNodeView(child)).toList(),
          ),
        )
      ],
    );
  }
}
