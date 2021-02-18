import 'package:box/box.dart';
import 'package:flutter/material.dart';

import 'boxes.dart';

class ChildrenBox extends MultiBox<Widget> {
  ChildrenBox({List<ChildBox> data})
      : super(
            data: data,
            onAdd: (parent, [value]) => ChildBox.value(value, parent: parent));

  @override
  String get boxType => 'Children';
}
