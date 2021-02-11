import 'package:box/src/prop/prop.dart';
import 'package:flutter/material.dart';
import 'package:fountain/fountain.dart';

import 'mixins.dart';

mixin BoxMixin<T>
    implements
        ValueUpdateMixin<T>,
        FieldProvider<T>,
        EditorProvider,
        CodeProvider {
  String get code => buildCode(this);
  T get value;
  T get fieldValue => value;
  set value(dynamic value);
  Future execute();
  Sprinkle get sprinkle;

  @override
  void onValue(T value) {}

  void redraw() {
    sprinkle.notify();
  }

  @override
  Widget buildField(T value) => ErrorWidget.builder(FlutterErrorDetails(
      library: 'Prototype Framework',
      exception: '${this.runtimeType} has no field provided'));

  @override
  Widget buildEditor(Prop prop) => ErrorWidget.builder(FlutterErrorDetails(
      library: 'Prototype Framework',
      exception: '${this.runtimeType} has no editor provided'));

  // String get boxType {
  //   final type = this.runtimeType.toString();
  //   return type.substring(0, type.length - 3).replaceAll('\$', '.');
  // }
}
