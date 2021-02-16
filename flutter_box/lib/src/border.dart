import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class Border$allBox extends CompositeBox<Border> with ComplexLayoutProvider {
  Border$allBox({data = const {}, MultiBox parent})
      : width = Prop(
          box: DoubleBox.dynamic(data: data['width'] ?? 1),
          name: 'Width',
          defaultValue: 1,
          type: PropType.value,
        ),
        color = Prop(
          box: ColorBox.dynamic(data: data['color'] ?? Colors.white),
          name: 'Color',
          defaultValue: Colors.white,
          type: PropType.value,
        ),
        super(parent: parent);

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
