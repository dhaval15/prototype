import 'package:flutter/widgets.dart';
import 'tree_extensions.dart';

import '../../box.dart';
import 'node.dart';
export 'node.dart';
export 'tree_widget.dart';
export 'tree_provider.dart';
export 'tree_extensions.dart';

class Tree extends Node
    with CurrentMixin, EditorNotifier, TreeNotifier, ActionsProvider {
  final WidgetBox box;

  Tree._(List<Node> children, this.box) : super(children: children) {
    current = this;
    notify();
  }

  factory Tree.of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<TreeProvider>().tree;

  factory Tree.fromBox(WidgetBox box) {
    final tree = Tree._([], box);
    tree.children.addAll(buildNodes(tree, box));
    return tree;
  }

  @override
  List<Node> route(ChildBox value) {
    if (value == null)
      return [this];
    else
      return [this, ...super.route(value)];
  }

  @override
  void notify() {
    notifyEditor();
    notifyTree();
  }
}
