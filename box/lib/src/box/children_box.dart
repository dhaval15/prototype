import 'package:box/box.dart';
import 'package:flutter/material.dart';

import 'boxes.dart';

class ChildrenBox extends MultiBox<Widget> {
  ChildrenBox(List<ChildBox> boxes)
      : super(boxes, onAdd: () => ChildBox.value(null));
}
