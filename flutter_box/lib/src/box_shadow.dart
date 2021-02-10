import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class BoxShadowBox extends CompositeBox<BoxShadow> with ComplexLayoutProvider {
  BoxShadowBox([data = const {}])
      : blurRadius = Prop(
          box: DoubleBox.dynamic(data['blurRadius'] ?? 4),
          name: 'BlurRadius',
          defaultValue: 4,
          type: PropType.value,
        ),
        color = Prop(
          box: ColorBox.dynamic(data['color'] ?? Colors.black),
          name: 'Color',
          defaultValue: Colors.black,
          type: PropType.value,
        ),
        spreadRadius = Prop(
          box: DoubleBox.dynamic(data['spreadRadius'] ?? 4),
          name: 'SpreadRadius',
          defaultValue: 4,
          type: PropType.value,
        ),
        offset = Prop(
          box: OffsetBox(data['offset'] ?? {}),
          name: 'Offset',
          type: PropType.value,
        ),
        super();

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
}
