import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class BoxShadowBox extends CompositeBox<BoxShadow> with ComplexLayoutProvider {
  BoxShadowBox({data = const {}, MultiBox parent})
      : blurRadius = Prop(
          box: DoubleBox.dynamic(data: data['blurRadius'] ?? 4),
          name: 'BlurRadius',
          defaultValue: 4,
          type: PropType.value,
        ),
        color = Prop(
          box: ColorBox.dynamic(data: data['color'] ?? Color(0x33000000)),
          name: 'Color',
          defaultValue: Color(0x33000000),
          type: PropType.value,
        ),
        spreadRadius = Prop(
          box: DoubleBox.dynamic(data: data['spreadRadius'] ?? 4),
          name: 'SpreadRadius',
          defaultValue: 4,
          type: PropType.value,
        ),
        offset = Prop(
          box: OffsetBox(data: data['offset'] ?? {}),
          name: 'Offset',
          type: PropType.value,
        ),
        super(parent: parent);

  final Prop blurRadius, color, spreadRadius, offset;

  @override
  List<Prop> get props => [blurRadius, color, spreadRadius, offset];

  @override
  BoxShadow get value => BoxShadow(
        blurRadius: blurRadius.value,
        color: color.value,
        spreadRadius: spreadRadius.value,
        offset: offset.value,
      );

  @override
  String get boxType => 'BoxShadow';
}
