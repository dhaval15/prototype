import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class BorderSideBox extends CompositeBox<BorderSide>
    with ComplexLayoutProvider {
  BorderSideBox([data = const {}])
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
  BorderSide get value => BorderSide(
        width: width.value,
        color: color.value,
      );
}
