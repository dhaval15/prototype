import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/providers/providers.dart';

import 'package:flutter/material.dart';
import 'package:lambda/lambda.dart';
import 'package:select/select.dart';

import 'boxes.dart';

abstract class BaseChildBox extends Lambda
    with
        BoxMixin<Widget>,
        ConverterMixin<Widget>,
        ChildMixin,
        SimpleEditorProvider {
  final sprinkle = Sprinkle();

  BaseChildBox(this.box) : super(CONST, [null]);

  BaseChildBox.value(value) : super(CONST, [value]);

  BaseChildBox.dynamic(value)
      : box = value is CompositeBox<Widget> ? value : null,
        super(CONST, value is CompositeBox<Widget> ? [null] : [value]);

  Widget boxedValue;

  CompositeBox<Widget> box;

  Widget get value => boxedValue;

  set value(dynamic value) {
    update(value);
    if (value is Widget)
      box = null;
    else
      box = value;
  }

  @override
  Future execute() async {
    await super.execute();
    value = box ?? value;
    super.sprinkle.listen(notify);
  }

  void notify(dynamic value) {
    boxedValue = convert(value);
    sprinkle.add(boxedValue);
  }

  @override
  Widget convert(value) {
    return box?.value ?? value;
  }
}
