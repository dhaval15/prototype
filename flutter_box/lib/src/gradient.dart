import 'package:flutter/material.dart';
import 'package:box/box.dart';

import 'flutter_box.dart';

class LinearGradientBox extends CompositeBox<LinearGradient>
    with ComplexLayoutProvider {
  LinearGradientBox({data = const {}})
      : colors = Prop(
          box: MultiBox(
              data: data['colors'] ??
                  [
                    ColorBox.dynamic(data: Colors.white),
                    ColorBox.dynamic(data: Colors.white),
                  ],
              onAdd: (parent) =>
                  ColorBox.dynamic(data: Colors.white, parent: parent)),
          name: 'Colors',
          type: PropType.value,
        ),
        begin = Prop(
          box: AlignmentBox(data: data['begin'] ?? {}),
          name: 'begin',
          type: PropType.value,
        ),
        end = Prop(
          box: AlignmentBox(data: data['end'] ?? {}),
          name: 'end',
          type: PropType.value,
        ),
        super();

  final Prop colors, begin, end;

  @override
  List<Prop> get props => [colors, begin, end];

  @override
  LinearGradient get value => LinearGradient(
        colors: colors.value?.cast<Color>() ?? [],
        begin: begin.value,
        end: end.value,
      );
  @override
  String get boxType => 'LinearGradient';
}

class RadialGradientBox extends CompositeBox<RadialGradient>
    with ComplexLayoutProvider {
  RadialGradientBox({data = const {}})
      : colors = Prop(
          box: MultiBox(
              data: data['colors'] ??
                  [
                    ColorBox.dynamic(data: Colors.white),
                    ColorBox.dynamic(data: Colors.white),
                  ],
              onAdd: (parent) =>
                  ColorBox.dynamic(data: Colors.white, parent: parent)),
          name: 'Colors',
          type: PropType.value,
        ),
        super();

  final Prop colors;

  @override
  List<Prop> get props => [colors];

  @override
  RadialGradient get value => RadialGradient(
        colors: colors.value?.cast<Color>() ?? [],
      );
  @override
  String get boxType => 'RadialGradient';
}

class GradientBox extends AbstractBox<Gradient> {
  GradientBox() : super(LinearGradientBox());

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
