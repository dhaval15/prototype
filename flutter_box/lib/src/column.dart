import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class ColumnBox extends MultiWidgetBox<Column> with ListViewLayoutProvider {
  ColumnBox({data = const {}, MultiBox parent})
      : children = Prop(
          box: ChildrenBox(data: data['children'] ?? []),
          name: 'Children',
          defaultValue: [],
          type: PropType.value,
        ),
        mainAxisSize = Prop(
          box: MainAxisSizeBox.dynamic(
              data: data['mainAxisSize'] ?? MainAxisSize.min),
          name: 'MainAxisSize',
          defaultValue: MainAxisSize.min,
          type: PropType.fromData(data['mainAxisSize']),
        ),
        mainAxisAlignment = Prop(
          box: MainAxisAlignmentBox.dynamic(
              data: data['mainAxisAlignment'] ?? MainAxisAlignment.start),
          name: 'MainAxisAlignment',
          defaultValue: MainAxisAlignment.start,
          type: PropType.fromData(data['mainAxisAlignment']),
        ),
        crossAxisAlignment = Prop(
          box: CrossAxisAlignmentBox.dynamic(
              data: data['crossAxisAlignment'] ?? CrossAxisAlignment.start),
          name: 'CrossAxisAlignment',
          defaultValue: CrossAxisAlignment.start,
          type: PropType.fromData(data['crossAxisAlignment']),
        ),
        super(parent: parent);

  final Prop children, mainAxisSize, mainAxisAlignment, crossAxisAlignment;

  @override
  List<Prop> get props =>
      [children, mainAxisSize, mainAxisAlignment, crossAxisAlignment];

  @override
  Column get widget => Column(
        children: children.value,
        mainAxisSize: mainAxisSize.value,
        mainAxisAlignment: mainAxisAlignment.value,
        crossAxisAlignment: crossAxisAlignment.value,
      );

  @override
  String get boxType => 'Column';
}
