import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class BeveledRectangleBorderBox extends CompositeBox<BeveledRectangleBorder>
    with ComplexLayoutProvider {
  BeveledRectangleBorderBox({data = const {}, MultiBox parent})
      : borderRadius = Prop(
          box: BorderRadius$onlyBox(data: data['borderRadius'] ?? {}),
          name: 'BorderRadius',
          defaultValue: BorderRadius.zero,
          type: PropType.value,
        ),
        side = Prop(
          box: BorderSideBox(data: data['side'] ?? {}),
          name: 'Side',
          defaultValue: BorderSide.none,
          type: PropType.value,
        ),
        super(parent: parent);

  final Prop borderRadius, side;

  @override
  List<Prop> get props => [borderRadius, side];

  @override
  BeveledRectangleBorder get value => BeveledRectangleBorder(
        borderRadius: borderRadius.value,
        side: side.value,
      );

  @override
  String get boxType => 'BeveledRectangleBorder';
}

class RoundedRectangleBorderBox extends CompositeBox<RoundedRectangleBorder>
    with ComplexLayoutProvider {
  RoundedRectangleBorderBox({data = const {}, MultiBox parent})
      : borderRadius = Prop(
          box: BorderRadius$onlyBox(data: data['borderRadius'] ?? {}),
          name: 'BorderRadius',
          defaultValue: BorderRadius.zero,
          type: PropType.value,
        ),
        side = Prop(
          box: BorderSideBox(data: data['side'] ?? {}),
          name: 'Side',
          defaultValue: BorderSide.none,
          type: PropType.value,
        ),
        super(parent: parent);

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
