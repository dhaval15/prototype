import 'package:flutter/material.dart';
import 'package:box/box.dart';

import 'flutter_box.dart';

class LinearGradientBox extends CompositeBox<LinearGradient>
    with ComplexLayoutProvider {
  LinearGradientBox({data = const {}})
      : colors = Prop<List<Color>>(
          box: MultiBox(
              data: data['colors'] ?? [Colors.red, Colors.yellow],
              onAdd: (parent, [value]) => ColorBox.dynamic(
                    data: value ?? Colors.white,
                    parent: parent,
                  )),
          name: 'Colors',
          type: PropType.value,
        ),
        begin = Prop(
          box: AlignmentBox(data: data['begin'] ?? {}),
          name: 'begin',
          defaultValue: Alignment.centerLeft,
          type: PropType.fromData(data['begin']),
        ),
        end = Prop(
          box: AlignmentBox(data: data['end'] ?? {}),
          name: 'end',
          defaultValue: Alignment.centerRight,
          type: PropType.fromData(data['end']),
        ),
        super();

  final Prop colors, begin, end;

  @override
  List<Prop> get props => [colors, begin, end];

  @override
  LinearGradient get value => LinearGradient(
        colors: colors.value,
        begin: begin.value,
        end: end.value,
      );

  @override
  String get boxType => 'LinearGradient';
}

class RadialGradientBox extends CompositeBox<RadialGradient>
    with ComplexLayoutProvider {
  RadialGradientBox({data = const {}})
      : colors = Prop<List<Color>>(
          box: MultiBox(
            data: data['colors'] ?? [Colors.red, Colors.yellow],
            onAdd: (parent, [value]) => ColorBox.dynamic(
              data: value ?? Colors.white,
              parent: parent,
            ),
          ),
          name: 'Colors',
          type: PropType.value,
        ),
        super();

  final Prop colors;

  @override
  List<Prop> get props => [colors];

  @override
  RadialGradient get value {
    return RadialGradient(
      colors: colors.value,
    );
  }

  @override
  String get boxType => 'RadialGradient';
}

class GradientBox extends AbstractBox<Gradient> {
  GradientBox({data = const {}, MultiBox parent})
      : super('Linear', data: data, parent: parent);

  @override
  String buildCode(boxMixin) {
    return '';
  }

  @override
  Map<String, CompositeBox<Gradient> Function(dynamic)> get inheritedBuilder =>
      {
        'Linear': (data) => LinearGradientBox(data: data),
        'Radial': (data) => RadialGradientBox(data: data),
      };
}
