import 'package:box/box.dart';
import 'package:flutter/material.dart';

import 'boxes.dart';

class ChildrenBox extends MultiBox<Widget> {
  ChildrenBox({List<ChildBox> data})
      : super(
            data: data,
            onAdd: (parent) => ChildBox.value(null, parent: parent));

  @override
  String get boxType => 'Children';
  @override
  List<Widget> get value {
    return super.value;
  }
  // sprinkle.last.isEmpty ? <Widget>[] : sprinkle.last.cast<Widget>();
}
