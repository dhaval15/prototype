import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class BoxDecorationBox extends CompositeBox<BoxDecoration>
    with ComplexLayoutProvider {
  BoxDecorationBox([data = const {}])
      : borderRadius = Prop(
          box: BorderRadius$onlyBox(data['borderRadius'] ?? {}),
          name: 'BorderRadius',
          type: PropType.fromData(data['borderRadius']),
        ),
        color = Prop(
          box: ColorBox.dynamic(data['color']),
          name: 'Color',
          type: PropType.fromData(data['color']),
        ),
        border = Prop(
          box: Border$allBox(data['border'] ?? {}),
          name: 'Border',
          type: PropType.fromData(data['border']),
        ),
        boxShadow = Prop(
          box: MultiBox(data['boxShadow'] ?? [], onAdd: () => BoxShadowBox()),
          name: 'BoxShadow',
          type: PropType.fromData(data['boxShadow']),
        ),
        gradient = Prop(
          box: LinearGradientBox(),
          name: 'Gradient',
          type: PropType.value,
        ),
        super();

  final Prop borderRadius, color, border, boxShadow, gradient;

  @override
  List<Prop> get props => [borderRadius, color, border, boxShadow, gradient];

  @override
  BoxDecoration get value => BoxDecoration(
        borderRadius: borderRadius.value,
        color: color.value,
        border: border.value,
        gradient: gradient.value,
        boxShadow: boxShadow.value?.cast<BoxShadow>(),
      );
}
