import 'package:box/box.dart';
import 'package:flutter/widgets.dart';

class TreeProvider extends StatelessWidget {
  final Widget child;
  final WidgetBox box;
  final Tree tree;

  TreeProvider({Key key, this.box, this.child})
      : tree = Tree.fromBox(box),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
