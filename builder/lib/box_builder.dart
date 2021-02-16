import 'dart:convert';
import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

import 'file_utils.dart';

void main(List<String> arguments) async {
  if (arguments.length < 2)
    printCode(arguments[0]);
  else
    writeCode(arguments[0], arguments[1]);
}

void printCode(String path) async {
  final inFile = File(path);
  if (!await inFile.isDirectory) {
    final data = await inFile.readAsString();
    final builder = BoxBuilder.fromString(data);
    print(builder.generateCode());
  } else {
    final directory = Directory(path);
    await for (final entity in directory.list()) {
      printCode(entity.path);
    }
  }
}

void writeCode(String inPath, String outPath) async {
  final inFile = File(inPath);
  final outFile = File(outPath);
  if (!await inFile.isDirectory &&
      (!await outFile.exists() || !await outFile.isDirectory)) {
    writeCodeFromFile(inFile, outFile);
  } else if (await inFile.isDirectory && await outFile.isDirectory) {
    final directory = Directory(inPath);
    await for (final entity in directory.list()) {
      writeCodeFromFile(
          File(entity.path),
          File(outFile.path +
              '/' +
              entity.path.split('/').last.replaceFirst('.prop', '.dart')));
    }
  } else {
    print(inPath);
    print(outPath);
    print('Unprobable condition');
  }
}

void writeCodeFromFile(File inFile, File outFile) async {
  final data = await inFile.readAsString();
  final list = data.split('\n\n');
  final buffer = StringBuffer();
  buffer.write(BoxBuilder.generateImports());
  for (final d in list) {
    final builder = BoxBuilder.fromString(d);
    buffer.write(builder.generateClass());
  }
  await outFile.writeAsString(DartFormatter().format(buffer.toString()));
}

class BoxBuilder {
  final List<Prop> props;
  final String type;
  final String name;
  final String output;
  final String layout;

  BoxBuilder({this.props, this.name, this.output, this.layout, this.type});

  factory BoxBuilder.fromList(List<String> list) {
    final data = list[0].split(RegExp(r'\s+'));
    return BoxBuilder(
      props: list.sublist(1).map((item) => Prop.fromString(item)).toList(),
      name: data[0],
      output: data[1],
      layout: data[2],
      type: data[3],
    );
  }

  factory BoxBuilder.fromString(String string) =>
      BoxBuilder.fromList(LineSplitter().convert(string));

  Map<String, dynamic> toJson() => {
        'props': props.map((prop) => prop.toString()).toList(),
      };

  @override
  String toString() {
    return JsonEncoder().convert(toJson());
  }

  String generateClass() {
    final builder = ClassBuilder();
    builder.name = output.replaceFirst('.', '\$') + 'Box';
    builder.extend = Reference('${type}Box<$name>');
    builder.mixins.add(Reference('${layout}LayoutProvider'));
    builder.methods.addAll([propsField, valueField, boxTypeField]);
    builder.constructors.add((ConstructorBuilder()
          ..optionalParameters.addAll([
            (ParameterBuilder()
                  ..named = true
                  ..name = 'data'
                  ..defaultTo = Code('const {}'))
                .build(),
            (ParameterBuilder()
                  ..named = true
                  ..type = Reference('MultiBox')
                  ..name = 'parent')
                .build(),
          ])
          ..initializers.addAll(initializers)
          ..initializers.add(Reference('super').call(
            [],
            {
              'parent': CodeExpression(Code('parent')),
            },
          ).code))
        .build());
    final emitter = DartEmitter();
    String code = builder.build().accept(emitter).toString();
    code = code.replaceFirst(';',
        ';\n \n final Prop ${props.map((prop) => prop.camelCaseLabel).join(',')};');
    code = code.replaceAll('@override', '\n @override');
    return code;
  }

  static String generateImports() {
    return '''
import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';
''';
  }

  String generateCode() {
    return DartFormatter().format('${generateImports()}${generateClass()}');
  }

  List<Code> get initializers => props
      .map((prop) =>
          Code('${prop.camelCaseLabel} = ${prop.constructorExpression}'))
      .toList();

  Method get propsField => (MethodBuilder()
        ..name = 'props'
        ..type = MethodType.getter
        ..annotations.add(CodeExpression(Code('override')))
        ..lambda = true
        ..body = Code('[${props.map((prop) => prop.camelCaseLabel).join(',')}]')
        ..returns = Reference('List<Prop>'))
      .build();

  Method get valueField => (MethodBuilder()
        ..name = type == 'Composite' ? 'value' : 'widget'
        ..type = MethodType.getter
        ..annotations.add(CodeExpression(Code('override')))
        ..lambda = true
        ..body =
            Code('$output(${props.map((prop) => prop.expression).join(',')},)')
        ..returns = Reference(name))
      .build();

  Method get boxTypeField => (MethodBuilder()
        ..name = 'boxType'
        ..type = MethodType.getter
        ..annotations.add(CodeExpression(Code('override')))
        ..lambda = true
        ..body = Code('\'$name\'')
        ..returns = Reference('String'))
      .build();

  Constructor get constructor => (ConstructorBuilder()
        ..optionalParameters.add((ParameterBuilder()
              ..name = 'data'
              ..defaultTo = Code('const {}'))
            .build())
        ..initializers.addAll(initializers)
        ..initializers.add(Reference('super').call(
          [],
        ).code))
      .build();
}

class Prop {
  final String label;
  final String extractor;
  final String type;
  final String defaultValue;
  final String fieldType;

  Prop({
    this.label,
    this.extractor,
    this.type,
    this.defaultValue,
    this.fieldType,
  });

  factory Prop.fromList(List<String> list) => Prop(
        label: list[0],
        extractor: list[1],
        type: list[2],
        defaultValue: list[3],
        fieldType: list[4],
      );

  factory Prop.fromString(String string) =>
      Prop.fromList(string.split(RegExp(r'\s+')));

  Map<String, dynamic> toJson() => {
        'label': label,
        'extractor': extractor,
        'type': type,
        'defaultValue': defaultValue,
        'fieldType': fieldType,
      };

  @override
  String toString() {
    return JsonEncoder.withIndent('  ').convert(toJson());
  }

  String get camelCaseLabel => label[0].toLowerCase() + label.substring(1);

  Field get field => (FieldBuilder()
        ..name = camelCaseLabel
        ..modifier = FieldModifier.final$
        ..type = Reference('Prop'))
      .build();

  String get expression => extractor.contains('#')
      ? '$camelCaseLabel.value'
      : '$camelCaseLabel:$camelCaseLabel.value';

  String get constructorExpression =>
      'Prop(box:$type(data:data[\'$extractor\'] ${defaultValue != 'null' ? '??' + _defaultValue : ''}),name:\'$label\',$_defaultValueExpression$_fieldTypeExpression$_indexExpression)';

  String get _fieldTypeExpression =>
      'type : ' +
      (fieldType == 'absent'
          ? 'PropType.fromData(data[\'$extractor\']),'
          : 'PropType.value,');

  String get _defaultValueExpression =>
      defaultValue != 'null' && defaultValue != '{}'
          ? 'defaultValue:$defaultValue,'
          : '';

  String get _defaultValue => defaultValue == '[]'
      ? '[]'
      : !type.contains('.dynamic')
          ? '{}'
          : defaultValue;

  String get _indexExpression => extractor.contains('#')
      ? 'index:${int.parse(extractor.replaceFirst('#', ''))},'
      : '';
}
