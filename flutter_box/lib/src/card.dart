import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class CardBox extends WidgetBox<Card> with ListViewLayoutProvider {
  CardBox([data = const {}])
      : child = Prop(
          box: ChildBox.dynamic(data['child']),
          name: 'Child',
          type: PropType.value,
        ),
        color = Prop(
          box: ColorBox.dynamic(data['color']),
          name: 'Color',
          type: PropType.value,
        ),
        elevation = Prop(
          box: DoubleBox.dynamic(data['elevation'] ?? 4),
          name: 'Elevation',
          defaultValue: 4,
          type: PropType.value,
        ),
        shape = Prop(
          box: BeveledRectangleBorderBox(data['shape'] ?? {}),
          name: 'Shape',
          type: PropType.value,
        ),
        super();

  final Prop child, color, elevation, shape;

  @override
  List<Prop> get props => [child, color, elevation, shape];

  @override
  Card get widget => Card(
        child: child.value,
        color: color.value,
        elevation: elevation.value,
        shape: shape.value,
      );
}
