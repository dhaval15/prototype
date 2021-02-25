import 'package:box/box.dart';
import 'node_mixin.dart';

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
