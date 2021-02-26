import 'dart:async';

import 'package:box/box.dart';
import 'package:flutter/material.dart';

import 'node.dart';

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

mixin CurrentMixin on Node {
  Node current;

  void onEvent(NodeEvent event) {
    if (event is AddNodeEvent) {
      final node = Node(
        parent: current,
        self: event.box,
      );
      node.children.addAll(buildNodes(node, event.box.box as WidgetBox));
      current.children.add(node);
      move(node);
      notify();
    } else if (event is RemoveNodeEvent) {
      find(event.box).remove();
      notify();
    } else if (event is UpdateNodeEvent) {
      final node = find(event.box);
      node.parent.children.remove(node);
      final newNode = Node(
        parent: node.parent,
        self: event.box,
      );
      node.children.addAll(buildNodes(node, event.box.box as WidgetBox));
      current.children.add(newNode);
      move(newNode);
      notify();
    }
  }

  void moveByValue(ChildBox childBox) {
    final node = current.find(childBox);
    move(node);
    notify();
  }

  bool back() {
    final parent = current.parent;
    if (parent == null) return false;
    current = parent;
    notify();
    return true;
  }

  void move(Node node) {
    current = node;
  }

  void notify();
}

mixin ActionsProvider on CurrentMixin {
  Future showAddPropsDialog(BuildContext context) async {
    final prop = await PropsDialog.show(
      context,
      current.box.props.where((prop) => prop.type == null).toList(),
    );
    if (prop != null) prop.enable();
  }

  @override
  bool drop([void Function(Node parent, ChildBox value, Node child) onDrop]) {
    return current.drop((parent, value, child) {
      print('After Drop ${parent.name} ${child.name} ${child.box}');
      parent.self.box = null;
      parent.self.box = child.box;
      move(parent);
      notify();
      onDrop?.call(parent, value, child);
    });
  }

  void wrap(BuildContext context) async {}
}

mixin EditorNotifier on CurrentMixin {
  final _editorController = StreamController<Widget>();

  Stream<Widget> get editorStream => _editorController.stream;

  void notifyEditor() {
    _editorController.add(Prop.onlyBox(current.box).field);
  }
}

mixin TreeNotifier on CurrentMixin {
  final _treeController = StreamController<Tree>();

  Stream<Tree> get treeStream => _treeController.stream;

  void notifyTree() {
    _treeController.add(this as Tree);
  }
}

List<Node> buildNodes(Node parent, WidgetBox box) {
  final List<Node> nodes = [];
  if (box != null) {
    for (final prop in box.props) {
      int index = 0;
      if (prop.box is ChildBox) {
        final box = prop.box as ChildBox;
        if (box.box != null) {
          final node = Node(parent: parent, self: box, index: index);
          index++;
          node.children.addAll(buildNodes(node, box.box));
          nodes.add(node);
        }
      } else if (prop.box is ChildrenBox) {
        for (final ChildBox box in (prop.box as ChildrenBox).boxes) {
          if (box.box != null) {
            final node = Node(parent: parent, self: box, index: index);
            index++;
            node.children.addAll(buildNodes(node, box.box));
            nodes.add(node);
          }
        }
      }
    }
  }
  return nodes;
}
