import 'package:petitparser/petitparser.dart';

import '../token.dart';
import 'spec1_definition.dart';

class Spec1Parser extends GrammarParser {
  Spec1Parser() : super(Spec1ParserDefinition());
}

class Spec1ParserDefinition extends Spec1GrammarDefinition {
  @override
  Parser func() => super.func().map(
        (list) => {
          'type': list[0],
          'params': list[1][1],
        },
      );

  @override
  Parser function() => super.function().map((list) => list[1]);

  @override
  Parser stringToken() =>
      super.stringToken().map((s) => s.substring(1, s.length - 1));

  @override
  Parser numberToken() => super.numberToken().map((s) => toNum(s));

  @override
  Parser trueToken() => super.trueToken().map((_) => true);

  @override
  Parser funcName() =>
      super.funcName().map((value) => value[0] + value[1].join());

  @override
  Parser falseToken() => super.falseToken().map((_) => false);
}
