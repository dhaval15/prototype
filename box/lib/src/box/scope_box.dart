import 'dart:collection';

import 'package:box/box.dart';
import 'package:box/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

mixin BoxGeneratorMixin {
  List<String> get types;
  any(String type);
}

class ScopeBox extends WidgetBox<Scope> with ScopeMixin, ColumnLayoutProvider {
  static BoxGeneratorMixin generator;
  ScopeBox([Map<String, dynamic> data = const {}])
      : child = Prop(
          box: ChildBox(data['child']),
          name: 'Child',
          type: PropType.value,
        ),
        variables = HashMap.from(data['variables'] ?? {}),
        super() {
    variables.values.forEach((v) => v.execute());
  }

  final Map<String, BoxMixin> variables;
  final Prop child;

  List<Prop> get props => [child];

  Future addParam(String name, BoxMixin param) async {
    variables[name] = param;
    await param.execute();
  }

  @override
  Scope get widget => Scope(child: child.value);

  @override
  Widget buildField(Widget value) => ScopeView(
        prop: Prop.onlyBox(this),
        field: (context) => Column(
          children: [
            child.editor,
            ...variables.entries
                .map((e) => Prop.onlyBox(e.value, name: e.key).editor)
                .toList(),
          ],
        ),
      );
}
