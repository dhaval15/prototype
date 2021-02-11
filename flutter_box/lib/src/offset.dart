import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class OffsetBox extends CompositeBox<Offset> with RowLayoutProvider {
  OffsetBox([data = const {}])
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
  Offset get value => Offset(
        x.value,
        y.value,
      );
  @override
  String get boxType => 'Offset';
}
