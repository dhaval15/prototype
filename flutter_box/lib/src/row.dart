import 'package:flutter/material.dart';
import 'package:box/box.dart';

class RowBox extends WidgetBox<Row> with ListViewLayoutProvider {
  RowBox([data = const {}])
      : children = Prop(
          box: MultiBox<Widget>(data['children'] ?? {}),
          name: 'Children',
          defaultValue: [],
          type: PropType.value,
        ),
        mainAxisSize = Prop(
          box: MainAxisSizeBox.dynamic(data['mainAxisSize']),
          name: 'MainAxisSize',
          type: PropType.fromData(data['mainAxisSize']),
        ),
        mainAxisAlignment = Prop(
          box: MainAxisAlignmentBox.dynamic(data['mainAxisAlignment']),
          name: 'MainAxisAlignment',
          type: PropType.fromData(data['mainAxisAlignment']),
        ),
        crossAxisAlignment = Prop(
          box: CrossAxisAlignmentBox.dynamic(data['crossAxisAlignment']),
          name: 'CrossAxisAlignment',
          type: PropType.fromData(data['crossAxisAlignment']),
        ),
        super();

  final Prop children, mainAxisSize, mainAxisAlignment, crossAxisAlignment;

  @override
  List<Prop> get props =>
      [children, mainAxisSize, mainAxisAlignment, crossAxisAlignment];

  @override
  Row get widget => Row(
        children: children.value,
        mainAxisSize: mainAxisSize.value,
        mainAxisAlignment: mainAxisAlignment.value,
        crossAxisAlignment: crossAxisAlignment.value,
      );
}
