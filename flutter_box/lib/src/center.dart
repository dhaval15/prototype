import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class CenterBox extends WidgetBox<Center> with ComplexLayoutProvider {
  CenterBox({data = const {}, MultiBox parent})
      : child = Prop(
          box: ChildBox.dynamic(data: data['child']),
          name: 'Child',
          type: PropType.value,
        ),
        super(parent: parent);

  final Prop child;

  @override
  List<Prop> get props => [child];

  @override
  Center get widget => Center(
        child: child.value,
      );

  @override
  String get boxType => 'Center';
}
