import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class CardBox extends WidgetBox<Card> with ListViewLayoutProvider {
  CardBox({data = const {}, MultiBox parent})
      : child = Prop(
          box: ChildBox.dynamic(data: data['child']),
          name: 'Child',
          type: PropType.value,
        ),
        color = Prop(
          box: ColorBox.dynamic(data: data['color']),
          name: 'Color',
          type: PropType.value,
        ),
        elevation = Prop(
          box: DoubleBox.dynamic(data: data['elevation'] ?? 4),
          name: 'Elevation',
          defaultValue: 4,
          type: PropType.value,
        ),
        shape = Prop(
          box: BeveledRectangleBorderBox(data: data['shape'] ?? {}),
          name: 'Shape',
          type: PropType.value,
        ),
        super(parent: parent);

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

  @override
  String get boxType => 'Card';
}
