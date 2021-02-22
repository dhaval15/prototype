import 'package:feather/src/framework/framework.dart';
import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

class TreeView extends StatefulWidget {
  final CompositeBox<Widget> box;

  const TreeView({Key key, this.box}) : super(key: key);

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            setState(() {});
          },
          icon: Icon(Icons.refresh),
        ).topRight(),
        Padding(
          padding: EdgeInsets.all(4),
          child: NodeView(node: buildNode(widget.box, [0])),
        )
      ],
    );
  }
}

class Node {
  final String value;
  final List<int> indices;
  final List<Node> nodes;

  Node(this.value, this.nodes, this.indices);
}

Node buildNode(WidgetBox box, List<int> indices) {
  final value = box.boxType;
  if (box is MultiWidgetBox) {
    final childrenNodes = (box.children.box as MultiBox)
        .boxes
        .map((box) => box as ChildBox)
        .map((box) => box.box)
        .where((box) => box != null)
        .mapIndexed((index, box) => buildNode(box, [...indices, index]))
        .toList();
    return Node(value, childrenNodes, indices);
  } else {
    final childrenNodes = box.props
        .where((prop) => prop.box is ChildBox)
        .map((prop) => (prop.box as ChildBox).box)
        .where((box) => box != null)
        .mapIndexed((index, box) => buildNode(box, [...indices, index]))
        .toList();
    return Node(value, childrenNodes, indices);
  }
}

class NodeView extends StatelessWidget {
  final Node node;

  const NodeView({Key key, this.node}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            EditContextProvider.of(context).jump(node.indices);
          },
          child: Text(
            node.value,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: node.nodes.map((node) => NodeView(node: node)).toList(),
        ).padding(left: 8),
      ],
    );
  }
}

extension<T> on Iterable<T> {
  List<R> mapIndexed<R>(R Function(int index, T) f) {
    final List<R> list = [];
    final iterator = this.iterator;
    for (int index = 0; index < this.length; index++) {
      iterator.moveNext();
      list.add(f(index, iterator.current));
    }
    return list;
  }
}
