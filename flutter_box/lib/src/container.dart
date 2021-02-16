import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class ContainerBox extends WidgetBox<Container> with ListViewLayoutProvider {
  ContainerBox({data = const {}, MultiBox parent})
      : width = Prop(
          box: DoubleBox.dynamic(data: data['width']),
          name: 'Width',
          type: PropType.value,
        ),
        height = Prop(
          box: DoubleBox.dynamic(data: data['height']),
          name: 'Height',
          type: PropType.value,
        ),
        child = Prop(
          box: ChildBox.dynamic(data: data['child']),
          name: 'Child',
          type: PropType.value,
        ),
        color = Prop(
          box: ColorBox.dynamic(data: data['color']),
          name: 'Color',
          type: PropType.fromData(data['color']),
        ),
        decoration = Prop(
          box: BoxDecorationBox(data: data['decoration'] ?? {}),
          name: 'Decoration',
          type: PropType.fromData(data['decoration']),
        ),
        super(parent: parent);

  final Prop width, height, child, color, decoration;

  @override
  List<Prop> get props => [width, height, child, color, decoration];

  @override
  Container get widget => Container(
        width: width.value,
        height: height.value,
        child: child.value,
        color: color.value,
        decoration: decoration.value,
      );

  @override
  String get boxType => 'Container';
}
