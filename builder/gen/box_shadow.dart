import 'package:flutter/material.dart';
import 'package:box/box.dart';

class BoxShadowBox extends CompositeBox<BoxShadow> with ColumnLayoutMixin {
  BoxShadowBox([data = const {}])
      : blurRadius = Prop(
          box: DoubleSelectBox.dynamic(data['blurRadius'] ?? 4),
          label: 'BlurRadius',
          defaultValue: 4,
          type: PropType.permanant,
        ),
        color = Prop(
          box: ColorSelectBox.dynamic(data['color'] ?? Colors.black),
          label: 'Color',
          defaultValue: Colors.black,
          type: PropType.permanant,
        ),
        spreadRadius = Prop(
          box: DoubleSelectBox.dynamic(data['spreadRadius'] ?? 4),
          label: 'SpreadRadius',
          defaultValue: 4,
          type: PropType.permanant,
        ),
        offsetX = Prop(
          box: DoubleSelectBox.dynamic(data['offsetX'] ?? 4),
          label: 'OffsetX',
          defaultValue: 4,
          type: PropType.permanant,
        ),
        offsetY = Prop(
          box: DoubleSelectBox.dynamic(data['offsetY'] ?? 4),
          label: 'OffsetY',
          defaultValue: 4,
          type: PropType.permanant,
        ),
        super();

  final Prop blurRadius, color, spreadRadius, offsetX, offsetY;

  @override
  List<Prop> get props => [blurRadius, color, spreadRadius, offsetX, offsetY];

  @override
  BoxShadow get value => BoxShadow(
        blurRadius: blurRadius.value,
        color: color.value,
        spreadRadius: spreadRadius.value,
        offsetX: offsetX.value,
        offsetY: offsetY.value,
      );
}
