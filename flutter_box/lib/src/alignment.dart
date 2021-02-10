import 'package:flutter/material.dart';
import 'package:box/box.dart';

class AlignmentBox extends CompositeBox<Alignment> with RowLayoutProvider {
  AlignmentBox([data = const {}])
      : x = Prop(
          box: DoubleBox.dynamic(data['#0'] ?? 0),
          name: 'X',
          defaultValue: 0,
          type: PropType.value,
          index: 0,
        ),
        y = Prop(
          box: DoubleBox.dynamic(data['#1'] ?? 0),
          name: 'Y',
          defaultValue: 0,
          type: PropType.value,
          index: 1,
        ),
        super();

  final Prop x, y;

  @override
  List<Prop> get props => [x, y];

  @override
  Alignment get value => Alignment(
        x.value,
        y.value,
      );
}
