import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class BorderRadius$onlyBox extends CompositeBox<BorderRadius>
    with ComplexLayoutProvider {
  BorderRadius$onlyBox({data = const {}, MultiBox parent})
      : topLeft = Prop(
          box: RadiusBox.dynamic(data: data['topLeft'] ?? 0),
          name: 'TopLeft',
          defaultValue: 0,
          type: PropType.value,
        ),
        topRight = Prop(
          box: RadiusBox.dynamic(data: data['topRight'] ?? 0),
          name: 'TopRight',
          defaultValue: 0,
          type: PropType.value,
        ),
        bottomRight = Prop(
          box: RadiusBox.dynamic(data: data['bottomRight'] ?? 0),
          name: 'BottomRight',
          defaultValue: 0,
          type: PropType.value,
        ),
        bottomLeft = Prop(
          box: RadiusBox.dynamic(data: data['bottomLeft'] ?? 0),
          name: 'BottomLeft',
          defaultValue: 0,
          type: PropType.value,
        ),
        super(parent: parent);

  final Prop topLeft, topRight, bottomRight, bottomLeft;

  @override
  List<Prop> get props => [topLeft, topRight, bottomRight, bottomLeft];

  @override
  BorderRadius get value => BorderRadius.only(
        topLeft: topLeft.value,
        topRight: topRight.value,
        bottomRight: bottomRight.value,
        bottomLeft: bottomLeft.value,
      );

  @override
  String get boxType => 'BorderRadius';
}
