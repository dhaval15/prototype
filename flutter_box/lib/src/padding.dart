import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class PaddingBox extends WidgetBox<Padding> with ListViewLayoutProvider {
  PaddingBox({data = const {}, MultiBox parent})
      : child = Prop(
          box: ChildBox.dynamic(data: data['child']),
          name: 'Child',
          type: PropType.value,
        ),
        padding = Prop(
          box: EdgeInsets$onlyBox(data: data['padding'] ?? {}),
          name: 'Padding',
          type: PropType.value,
        ),
        super(parent: parent);

  final Prop child, padding;

  @override
  List<Prop> get props => [child, padding];

  @override
  Padding get widget => Padding(
        child: child.value,
        padding: padding.value,
      );

  @override
  String get boxType => 'Padding';
}
