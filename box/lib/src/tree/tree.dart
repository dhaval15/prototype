import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../box.dart';
import 'node.dart';
export 'node.dart';
export 'tree_widget.dart';
export 'tree_provider.dart';
export 'tree_extensions.dart';

abstract class NodeEvent {}

class AddNodeEvent extends NodeEvent {
  final ChildBox box;

  AddNodeEvent(this.box);
}

class RemoveNodeEvent extends NodeEvent {
  final ChildBox box;

  RemoveNodeEvent(this.box);
}

class UpdateNodeEvent extends NodeEvent {
  final ChildBox box;

  UpdateNodeEvent(this.box);
}

class Tree extends Node {
  final WidgetBox box;
  Node _current;

  Tree._(List<Node> children, this.box) : super(children: children) {
    _current = this;
    notify();
  }

  factory Tree.of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<TreeProvider>().tree;

  void onEvent(NodeEvent event) {
    if (event is AddNodeEvent) {
      final node = Node(
        parent: _current,
        self: event.box,
      );
      node.children.addAll(_buildNodes(node, event.box.box as WidgetBox));
      _current.children.add(node);
      move(node);
      notify();
    } else if (event is RemoveNodeEvent) {
      remove(event.box);
      notify();
    } else if (event is UpdateNodeEvent) {
      final node = find(event.box);
      node.parent.children.remove(node);
      final newNode = Node(
        parent: node.parent,
        self: event.box,
      );
      node.children.addAll(_buildNodes(node, event.box.box as WidgetBox));
      _current.children.add(newNode);
      move(newNode);
      notify();
    }
  }

  factory Tree.fromBox(WidgetBox box) {
    final tree = Tree._([], box);
    tree.children.addAll(_buildNodes(tree, box));
    return tree;
  }

  void moveByValue(ChildBox childBox) {
    final node = _current.find(childBox);
    move(node);
    notify();
  }

  bool back() {
    final parent = _current.parent;
    if (parent == null) return false;
    _current = parent;
    notify();
    return true;
  }

  void move(Node node) {
    _current = node;
  }

  @override
  List<Node> route(ChildBox value) {
    if (value == null)
      return [this];
    else
      return [this, ...super.route(value)];
  }

  final _treeController = StreamController<Tree>();

  Stream<Tree> get treeStream => _treeController.stream;

  final _editorController = StreamController<Widget>();

  Stream<Widget> get editorStream => _editorController.stream;

  void notify() {
    _treeController.add(this);
    _editorController.add(Prop.onlyBox(_current.box).field);
  }

  void dispose() {
    _editorController.close();
    _treeController.close();
  }

  Future showAddPropsDialog(BuildContext context) async {
    final prop = await PropsDialog.show(
      context,
      _current.box.props.where((prop) => prop.type == null).toList(),
    );
    if (prop != null) prop.enable();
  }
}

List<Node> _buildNodes(Node parent, WidgetBox box) {
  final List<Node> nodes = [];
  if (box != null) {
    for (final prop in box.props) {
      int index = 0;
      if (prop.box is ChildBox) {
        final box = prop.box as ChildBox;
        if (box.box != null) {
          final node = Node(parent: parent, self: box, index: index);
          index++;
          node.children.addAll(_buildNodes(node, box.box));
          nodes.add(node);
        }
      } else if (prop.box is ChildrenBox) {
        for (final ChildBox box in (prop.box as ChildrenBox).boxes) {
          if (box.box != null) {
            final node = Node(parent: parent, self: box, index: index);
            index++;
            node.children.addAll(_buildNodes(node, box.box));
            nodes.add(node);
          }
        }
      }
    }
  }
  return nodes;
}
