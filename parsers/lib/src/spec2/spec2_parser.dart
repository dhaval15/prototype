import 'dart:collection';

import 'package:petitparser/petitparser.dart';
import '../token.dart';
import 'spec2_definition.dart';

class Spec2Parser extends GrammarParser {
  Spec2Parser() : super(Spec2ParserDefinition());
}

class Spec2ParserDefinition extends Spec2GrammarDefinition {
  @override
  Parser component() => super.component().map((value) {
        return {
          'type': value[1],
          'params': value[3],
        };
      });

  @override
  Parser componentBody() => super.componentBody().map((value) => value[2]);

  @override
  Parser componentParameters() => super.componentParameters().map((v) {
        final value = v[0];
        List<MapEntry<String, dynamic>> entries = [];
        for (int i = 0; i < value.length; i++) {
          MapEntry<String, dynamic> entry = value[i];
          entries.add(MapEntry(entry.key ?? '#$i', entry.value));
        }
        return HashMap.fromEntries(entries);
      });

  @override
  Parser paramName() => super.paramName().map((value) => value[0]);

  @override
  Parser componentParam() => super
      .componentParam()
      .map((value) => MapEntry<String, dynamic>(value[0], value[2]));

  @override
  Parser variableName() => super
      .variableName()
      .map((value) => [value[0], value[1].join('')].join(''));

  @override
  Parser variable() => super.variable().map((value) => {
        'type': 'enum',
        'params': [
          value[0],
          value[1][1],
        ],
      });

  @override
  Parser listToken() => super.listToken().map((value) => value[1]);

  @override
  Parser colorToken() => super.colorToken().map((value) => value);

  @override
  Parser stringToken() =>
      super.stringToken().map((value) => value.substring(1, value.length - 1));

  @override
  Parser numberToken() => super.numberToken().map((value) => toNum(value));
}
