/* Rules
 */

import 'package:petitparser/petitparser.dart';
import 'package:parsers/parsers.dart';

class Spec1GrammarDefinition extends GrammarDefinition with TokenMixin {
  Parser params() =>
      ref(token, OPEN_PARENTHESIS) &
      ref(elements).optional() &
      ref(token, CLOSE_PARENTHESIS);

  Parser elements() =>
      ref(expr).separatedBy(ref(token, COMMA), includeSeparators: false);

  Parser lambdas() => ref(funcName);

  Parser func() => ref(lambdas) & ref(params);

  Parser expr() => ref(func) | ref(value);

  Parser function() => ref(token, DOLLAR) & ref(func) & ref(token, DOLLAR);

  @override
  Parser runtime() => ref(function) | ref(value);

  Parser value() =>
      ref(stringToken) | ref(numberToken) | ref(trueToken) | ref(falseToken);

  Parser trueToken() => ref(token, 'true');

  Parser falseToken() => ref(token, 'false');

  Parser nullToken() => ref(token, 'null');

  Parser stringToken() => ref(token, ref(stringPrimitive), 'string');

  Parser numberToken() => ref(token, ref(numberPrimitive), 'number');

  Parser characterPrimitive() =>
      ref(characterNormal) | ref(characterEscape) | ref(characterUnicode);

  Parser characterNormal() => pattern('^"\\');

  Parser characterEscape() => char('\\') & pattern(jsonEscapeChars.keys.join());

  Parser characterUnicode() => string('\\u') & pattern('0-9A-Fa-f').times(4);

  Parser funcName() => pattern('_A-Za-z') & pattern('_0-9A-Za-z').star();

  Parser numberPrimitive() =>
      char('-').optional() &
      char('0').or(digit().plus()) &
      char('.').seq(digit().plus()).optional() &
      pattern('eE')
          .seq(pattern('-+').optional())
          .seq(digit().plus())
          .optional();

  Parser stringPrimitive() =>
      char('"') & ref(characterPrimitive).star() & char('"');

  Parser parameter() => ref(characterPrimitive).star();
}
