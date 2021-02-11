import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class BeveledRectangleBorderBox extends CompositeBox<BeveledRectangleBorder>
    with ComplexLayoutProvider {
  BeveledRectangleBorderBox([data = const {}])
      : borderRadius = Prop(
          box: BorderRadius$onlyBox(data['borderRadius'] ?? {}),
          name: 'BorderRadius',
          defaultValue: BorderRadius.zero,
          type: PropType.value,
        ),
        side = Prop(
          box: BorderSideBox(data['side'] ?? {}),
          name: 'Side',
          defaultValue: BorderSide.none,
          type: PropType.value,
        ),
        super();

  final Prop borderRadius, side;

  @override
  List<Prop> get props => [borderRadius, side];

  @override
  BeveledRectangleBorder get value => BeveledRectangleBorder(
        borderRadius: borderRadius.value,
        side: side.value,
      );
  @override
  String get boxType => 'Container';
}

class RoundedRectangleBorderBox extends CompositeBox<RoundedRectangleBorder>
    with ComplexLayoutProvider {
  RoundedRectangleBorderBox([data = const {}])
      : borderRadius = Prop(
          box: BorderRadius$onlyBox(data['borderRadius'] ?? {}),
          name: 'BorderRadius',
          defaultValue: BorderRadius.zero,
          type: PropType.value,
        ),
        side = Prop(
          box: BorderSideBox(data['side'] ?? {}),
          name: 'Side',
          defaultValue: BorderSide.none,
          type: PropType.value,
        ),
        super();

  final Prop borderRadius, side;

  @override
  List<Prop> get props => [borderRadius, side];

  @override
  RoundedRectangleBorder get value => RoundedRectangleBorder(
        borderRadius: borderRadius.value,
        side: side.value,
      );
  @override
  String get boxType => 'RoundedRectangleBorder';
}
