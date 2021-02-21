import 'dart:async';

import 'package:box/box.dart';
import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/providers/providers.dart';

import 'package:flutter/material.dart';
import 'package:lambda/lambda.dart';

import 'boxes.dart';

abstract class AbstractBox<T> extends Lambda
    with BoxMixin<T>, ConverterMixin<T>, AbstractEditorProvider, PropsProvider {
  final sprinkle = Sprinkle();
  final MultiBox parent;

  String currentType;

  AbstractBox(String type, {dynamic data, this.parent})
      : currentType = type,
        super(CONST, [null]) {
    box = inheritedBuilder[type](data);
  }

  AbstractBox.dynamic({data, this.parent})
      : box = data is CompositeBox<T> ? data : null,
        super(CONST, data is CompositeBox<Widget> ? [null] : [data]);

  T boxedValue;

  CompositeBox<T> box;

  void setInherited(String type) async {
    if (type == currentType) return;
    final json = JsonEngine.encode(box);
    final newBox = inheritedBuilder[type](json);
    value = null;
    value = newBox;
    currentType = type;
  }

  Map<String, CompositeBox<T> Function(dynamic)> get inheritedBuilder;

  List<String> get inheritedTypes => inheritedBuilder.keys.toList();

  @override
  List<Prop> get props => box.props;

  T get value => boxedValue;

  set value(dynamic value) {
    update(value);
    if (value is T)
      box = null;
    else
      box = value;
  }

  @override
  Widget buildField(value) {
    return box.buildField(value);
  }

  @override
  Future execute() async {
    await super.execute();
    value = box ?? value;
    super.sprinkle.listen(notify);
  }

  void notify(dynamic value) {
    boxedValue = box?.value ?? value;
    sprinkle.add(boxedValue);
  }

  @override
  T convert(value) {
    return value;
  }
}
