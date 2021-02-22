import 'package:box/box.dart';
import 'package:flutter/material.dart';

import 'boxes.dart';

class ChildrenBox extends MultiBox<Widget> {
  ChildrenBox({List data})
      : super(
            data: data,
            onAdd: (parent, [value]) =>
                ChildBox.dynamic(data: value, parent: parent));

  @override
  String get boxType => 'Children';
}
