import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class EdgeInsets$onlyBox extends CompositeBox<EdgeInsets>
    with ComplexLayoutProvider {
  EdgeInsets$onlyBox({data = const {}, MultiBox parent})
      : left = Prop(
          box: DoubleBox.dynamic(data: data['left'] ?? 0),
          name: 'Left',
          defaultValue: 0,
          type: PropType.value,
        ),
        top = Prop(
          box: DoubleBox.dynamic(data: data['top'] ?? 0),
          name: 'Top',
          defaultValue: 0,
          type: PropType.value,
        ),
        right = Prop(
          box: DoubleBox.dynamic(data: data['right'] ?? 0),
          name: 'Right',
          defaultValue: 0,
          type: PropType.value,
        ),
        bottom = Prop(
          box: DoubleBox.dynamic(data: data['bottom'] ?? 0),
          name: 'Bottom',
          defaultValue: 0,
          type: PropType.value,
        ),
        super(parent: parent);

  final Prop left, top, right, bottom;

  @override
  List<Prop> get props => [left, top, right, bottom];

  @override
  EdgeInsets get value => EdgeInsets.only(
        left: left.value,
        top: top.value,
        right: right.value,
        bottom: bottom.value,
      );

  @override
  String get boxType => 'EdgeInsets';
}

class EdgeInsets$symmetricBox extends CompositeBox<EdgeInsets>
    with ComplexLayoutProvider {
  EdgeInsets$symmetricBox({data = const {}, MultiBox parent})
      : vertical = Prop(
          box: DoubleBox.dynamic(data: data['vertical'] ?? 0),
          name: 'Vertical',
          defaultValue: 0,
          type: PropType.value,
        ),
        horizontal = Prop(
          box: DoubleBox.dynamic(data: data['horizontal'] ?? 0),
          name: 'Horizontal',
          defaultValue: 0,
          type: PropType.value,
        ),
        super(parent: parent);

  final Prop vertical, horizontal;

  @override
  List<Prop> get props => [vertical, horizontal];

  @override
  EdgeInsets get value => EdgeInsets.symmetric(
        vertical: vertical.value,
        horizontal: horizontal.value,
      );

  @override
  String get boxType => 'EdgeInsets';
}

class EdgeInsets$allBox extends CompositeBox<EdgeInsets>
    with ComplexLayoutProvider {
  EdgeInsets$allBox({data = const {}, MultiBox parent})
      : all = Prop(
          box: DoubleBox.dynamic(data: data['#0'] ?? 0),
          name: 'All',
          defaultValue: 0,
          type: PropType.value,
          index: 0,
        ),
        super(parent: parent);

  final Prop all;

  @override
  List<Prop> get props => [all];

  @override
  EdgeInsets get value => EdgeInsets.all(
        all.value,
      );

  @override
  String get boxType => 'EdgeInsets';
}
