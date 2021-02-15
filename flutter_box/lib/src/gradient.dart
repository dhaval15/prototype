import 'package:flutter/material.dart';
import 'package:box/box.dart';

import 'flutter_box.dart';

class LinearGradientBox extends CompositeBox<LinearGradient>
    with ComplexLayoutProvider {
  LinearGradientBox([data = const {}])
      : colors = Prop(
          box: MultiBox(
              data: data['colors'] ?? [],
              onAdd: (parent) =>
                  ColorBox.dynamic(data: Colors.white, parent: parent)),
          name: 'Colors',
          type: PropType.fromData(data['colors']),
        ),
        begin = Prop(
          box: AlignmentBox(data: data['begin'] ?? {}),
          name: 'begin',
          type: PropType.value,
        ),
        end = Prop(
          box: AlignmentBox(data: data['begin'] ?? {}),
          name: 'begin',
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
