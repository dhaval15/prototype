import 'package:box/src/prop/prop.dart';
import 'package:flutter/material.dart';

export 'prop_mixin.dart';
export 'box_mixin.dart';
export 'scope_mixin.dart';
export 'prop_type.dart';

mixin ValueUpdateMixin<T> {
  void onValue(T value);
}

mixin ConverterMixin<T> {
  T convert(value) {
    return value;
  }
}

mixin FieldProvider<T> {
  Widget buildField(T value);
}

mixin EditorProvider {
  Widget buildEditor(Prop prop);
}

mixin LayoutProvider {
  Widget buildLayout(List<Widget> children);
}

mixin PropsProvider {
  List<Prop> get props;
}

mixin OptionsProvider<T> implements ConverterMixin<T> {
  Map<String, dynamic> get options;

  @override
  T convert(value) {
    if (value is T)
      return value;
    else if (value is String) {
      final v = options[value];
      if (v != null)
        return v;
      else
        throw 'value should not be null';
    } else
      throw '$value is not type of ${T.runtimeType}';
  }
}

mixin CodeProvider {
  String buildCode(dynamic boxMixin) => throw 'Code Extension not implemented';
}
mixin BoxTypeMixin {
  String get boxType;
  //{
  // final type = this.runtimeType.toString();
  // return type.substring(0, type.length - 3).replaceAll('\$', '.');
  // }
}
