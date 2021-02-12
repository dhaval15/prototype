import 'package:flutter/material.dart';
import 'package:box/box.dart';

class RowBox extends MultiWidgetBox<Row> with ListViewLayoutProvider {
  RowBox([data = const {}])
      : children = Prop(
          box: ChildrenBox(data['children'] ?? []),
          name: 'Children',
          defaultValue: [],
          type: PropType.value,
        ),
        mainAxisSize = Prop(
          box: MainAxisSizeBox.dynamic(data['mainAxisSize']),
          name: 'MainAxisSize',
          defaultValue: MainAxisSize.min,
          type: PropType.fromData(data['mainAxisSize']),
        ),
        mainAxisAlignment = Prop(
          box: MainAxisAlignmentBox.dynamic(data['mainAxisAlignment']),
          name: 'MainAxisAlignment',
          defaultValue: MainAxisAlignment.start,
          type: PropType.fromData(data['mainAxisAlignment']),
        ),
        crossAxisAlignment = Prop(
          box: CrossAxisAlignmentBox.dynamic(data['crossAxisAlignment']),
          name: 'CrossAxisAlignment',
          defaultValue: CrossAxisAlignment.start,
          type: PropType.fromData(data['crossAxisAlignment']),
        ),
        super();

  final Prop children, mainAxisSize, mainAxisAlignment, crossAxisAlignment;

  @override
  List<Prop> get props =>
      [mainAxisSize, mainAxisAlignment, crossAxisAlignment, children];

  @override
  Row get widget => Row(
        children: children.value,
        mainAxisSize: mainAxisSize.value,
        mainAxisAlignment: mainAxisAlignment.value,
        crossAxisAlignment: crossAxisAlignment.value,
      );
  @override
  String get boxType => 'Radius';
}