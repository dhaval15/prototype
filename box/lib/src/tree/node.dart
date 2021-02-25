import 'package:box/box.dart';

mixin NodeMixin<T> {
  NodeMixin<T> get parent;
  T get self;
  int get index;
  List<NodeMixin<T>> get children;

  NodeMixin<T> find(T value) {
    if (self == value) return this;
    for (final child in children) {
      final found = child.find(value);
      if (found != null) return found;
    }
    return null;
  }

  List<NodeMixin<T>> route(T value) {
    final route = _route(value);
    print(route);
    if (route is List || route == null)
      return route;
    else
      return [route];
  }

  dynamic _route(T value) {
    if (self == value) {
      return this;
    } else {
      for (final child in children) {
        final route = child._route(value);
        if (route != null) {
          if (route is List)
            return <NodeMixin<T>>[child, ...route];
          else
            return <NodeMixin<T>>[route];
        }
      }
      return null;
    }
  }
}

mixin NodeNameProvider on NodeMixin<ChildBox> {
  WidgetBox get box;
  String get name => box?.boxType;
}

class Node with NodeMixin<ChildBox>, NodeNameProvider {
  Node parent;
  ChildBox self;
  int index;
  List<Node> children;

  Node({this.parent, this.self, List<Node> children, this.index = 0})
      : this.children = children ?? [];

  @override
  WidgetBox get box => self?.box;

  Map<String, dynamic> toJson() => {
        'parent': parent?.name,
        'self': name,
        'index': index,
        'children': children.map((item) => item.toJson()).toList(),
      };
}

class Tree extends Node {
  final WidgetBox box;
  Node _current;

  Tree._(List<Node> children, this.box) : super(children: children) {
    _current = this;
  }

  factory Tree.fromBox(WidgetBox box) {
    final tree = Tree._([], box);
    tree.children.addAll(_buildNodes(tree, box));
    return tree;
  }

  void moveByValue(ChildBox childBox) {
    final node = _current.find(childBox);
    move(node);
  }

  bool goBack() {
    final parent = _current.parent;
    if (parent == null) return false;
    _current = parent;
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
