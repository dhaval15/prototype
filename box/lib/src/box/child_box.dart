import 'package:box/box.dart';
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
  final MultiBox parent;

  BaseChildBox(this.box, {this.parent}) : super(CONST, [null]);

  BaseChildBox.value(value, {this.parent}) : super(CONST, [value]);

  BaseChildBox.dynamic({data, this.parent})
      : box = data is CompositeBox<Widget>
            ? data
            : data is Map
                ? ChildField.generator.widget(data['_type'])(data)
                : null,
        super(CONST,
            data is CompositeBox<Widget> || data is Map ? [null] : [data]);

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
