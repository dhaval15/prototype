import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

final _emitter = DartEmitter();

const _PROJECT_PATH = '/home/dhaval/Prototype/box/lib/src';

void generateOptionBoxes(List<List> options) {
  _writeProviders(options);
  _writeBoxes(options);
}

void _writeProviders(List<List> options) {
  final file = File('$_PROJECT_PATH/option_providers.dart');
  final providers =
      options.map((item) => _EnumBuilder(item).generateCode()).join('\n');
  final code = '''
import 'package:flutter/material.dart';
import 'base.dart';
$providers
		    ''';
  file.writeAsString(DartFormatter().format(code));
}

void _writeBoxes(List<List> options) {
  final file = File('$_PROJECT_PATH/option_boxes.dart');
  final boxes =
      options.map((item) => _EnumBuilder(item).generateBox()).join('\n');
  final code = '''
import 'package:flutter/material.dart';
import 'core_box.dart';
import 'fields.dart';
import 'option_providers.dart';
import 'converters.dart';
$boxes
		    ''';
  file.writeAsString(DartFormatter().format(code));
}

class _EnumBuilder<T> {
  final List<T> values;

  _EnumBuilder(this.values);

  String get params => values
      .map((value) => '\'${value.toString().split('.')[1]}\': $value,')
      .join('');

  String generateCode() {
    final builder = ClassBuilder();
    builder.name = '${type}Provider';
    builder.implements.add(Reference('OptionsProviderMixin<$type>'));
    builder.methods.add((MethodBuilder()
          ..name = 'options'
          ..type = MethodType.getter
          ..returns = Reference('Map<String,$type>')
          ..body = Code('{$params}')
          ..lambda = true)
        .build());
    return builder
        .build()
        .accept(_emitter)
        .toString()
        .replaceFirst('class', 'mixin');
  }

  String get type => values[0].runtimeType.toString().split('/')[0];

  String generateBox() => '''
	class ${type}Box = CoreBox<$type>
    with OptionFieldMixin<$type>, ${type}Provider, OptionConverter<$type>;
		    ''';
}
