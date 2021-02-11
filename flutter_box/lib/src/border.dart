import 'package:flutter/material.dart';
import 'package:box/box.dart';

class Border$allBox extends CompositeBox<Border> with ComplexLayoutProvider {
  Border$allBox([data = const {}])
      : width = Prop(
          box: DoubleBox.dynamic(data['width'] ?? 1),
          name: 'Width',
          defaultValue: 1,
          type: PropType.value,
        ),
        color = Prop(
          box: ColorBox.dynamic(data['color'] ?? Colors.white),
          name: 'Color',
          defaultValue: Colors.white,
          type: PropType.value,
        ),
        super();

  final Prop width, color;

  @override
  List<Prop> get props => [width, color];

  @override
  Border get value => Border.all(
        width: width.value,
        color: color.value,
      );
  @override
  String get boxType => 'Border';
}
