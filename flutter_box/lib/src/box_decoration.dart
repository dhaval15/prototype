import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class BoxDecorationBox extends CompositeBox<BoxDecoration>
    with ComplexLayoutProvider {
  BoxDecorationBox({data = const {}, MultiBox parent})
      : borderRadius = Prop(
          box: BorderRadius$onlyBox(data: data['borderRadius'] ?? {}),
          name: 'BorderRadius',
          type: PropType.fromData(data['borderRadius']),
        ),
        color = Prop(
          box: ColorBox.dynamic(data: data['color']),
          name: 'Color',
          type: PropType.fromData(data['color']),
        ),
        border = Prop(
          box: Border$allBox(data: data['border'] ?? {}),
          name: 'Border',
          type: PropType.fromData(data['border']),
        ),
        boxShadow = Prop(
          box: MultiBox(data: data['boxShadow']),
          name: 'BoxShadow',
          type: PropType.fromData(data['boxShadow']),
        ),
        super(parent: parent);

  final Prop borderRadius, color, border, boxShadow;

  @override
  List<Prop> get props => [borderRadius, color, border, boxShadow];

  @override
  BoxDecoration get value => BoxDecoration(
        borderRadius: borderRadius.value,
        color: color.value,
        border: border.value,
        boxShadow: boxShadow.value,
      );

  @override
  String get boxType => 'BoxDecoration';
}
