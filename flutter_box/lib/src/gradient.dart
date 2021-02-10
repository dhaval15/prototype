import 'package:flutter/material.dart';
import 'package:box/box.dart';

import 'flutter_box.dart';

class LinearGradientBox extends CompositeBox<LinearGradient>
    with ComplexLayoutProvider {
  LinearGradientBox([data = const {}])
      : colors = Prop(
          box: MultiBox(data['colors'] ?? [],
              onAdd: () => ColorBox.dynamic(Colors.white)),
          name: 'Colors',
          type: PropType.fromData(data['colors']),
        ),
        begin = Prop(
          box: AlignmentBox(data['begin'] ?? {}),
          name: 'begin',
          type: PropType.value,
        ),
        end = Prop(
          box: AlignmentBox(data['begin'] ?? {}),
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
}
