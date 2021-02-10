import 'package:flutter/material.dart';
import 'package:box/box.dart';

class ColumnBox extends WidgetBox<Column> with ListViewLayoutProvider {
  ColumnBox([data = const {}])
      : children = Prop(
          box: MultiBox<Widget>(data['children'] ?? [],
              onAdd: () => ChildBox.value(null)),
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
      [children, mainAxisSize, mainAxisAlignment, crossAxisAlignment];

  @override
  Column get widget => Column(
        children: children.value,
        mainAxisSize: mainAxisSize.value,
        mainAxisAlignment: mainAxisAlignment.value,
        crossAxisAlignment: crossAxisAlignment.value,
      );
}
