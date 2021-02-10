import 'package:flutter/material.dart';
import 'package:box/box.dart';

class CenterBox extends WidgetBox<Center> with ListViewLayoutProvider {
  CenterBox([data = const {}])
      : child = Prop(
          box: ChildBox.dynamic(data['child']),
          name: 'Child',
          type: PropType.value,
        ),
        super();

  final Prop child;

  @override
  List<Prop> get props => [child];

  @override
  Center get widget => Center(
        child: child.value,
      );
}
