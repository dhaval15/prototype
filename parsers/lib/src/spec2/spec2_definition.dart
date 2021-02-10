/* Rules
 */

import 'package:petitparser/petitparser.dart';
import 'package:parsers/parsers.dart';

class Spec2GrammarDefinition extends GrammarDefinition with TokenMixin {
  @override
  Parser runtime() => ref(component);

  Parser component() =>
      ref(whiteSpace) &
      ref(componentName) &
      ref(whiteSpace) &
      ref(componentBody) &
      ref(whiteSpace);

  Parser componentName() => ref(variableName);

  Parser componentBody() =>
      ref(token, OPEN_PARENTHESIS) &
      ref(whiteSpace) &
      ref(componentParameters).optional() &
      ref(whiteSpace) &
      ref(token, CLOSE_PARENTHESIS);

  Parser componentParameters() =>
      componentParam().separatedBy(ref(separator), includeSeparators: false) &
      ref(separator).optional();

  Parser separator() => ref(whiteSpace) & ref(token, COMMA) & ref(whiteSpace);

  Parser paramName() => ref(variableName) & ref(whiteSpace) & ref(token, COLON);

  Parser componentParam() =>
      paramName().optional() & ref(whiteSpace) & ref(paramValue);

  Parser variableName() => pattern('_A-Za-z') & pattern('_0-9A-Za-z').star();

  Parser variable() =>
      ref(variableName) & (ref(token, '.') & ref(variableName)).optional();

  Parser paramValue() =>
      ref(component) |
      ref(listToken) |
      ref(colorToken) |
      ref(variable) |
      ref(coreToken) |
      ref(stringToken) |
      ref(numberToken) |
      ref(trueToken) |
      ref(falseToken);

  Parser whiteSpace() => ref(blanks).star();

  Parser blanks() =>
      ref(token, WHITE_SPACE) | ref(token, NEW_LINE) & ref(token, TAB_LINE);

  Parser booleanToken() => ref(trueToken) | ref(falseToken);

  Parser trueToken() => ref(token, 'true');

  Parser falseToken() => ref(token, 'false');

  Parser nullToken() => ref(token, 'null');

  Parser listToken() =>
      ref(token, OPEN_BRACKET) &
      ref(paramValue).separatedBy(ref(separator), includeSeparators: false) &
      ref(token, CLOSE_BRACKET);

  Parser colorToken() => ref(token, ref(colorPrimitive), 'color');

  Parser stringToken() => ref(token, ref(stringPrimitive), 'string');

  Parser numberToken() => ref(token, ref(numberPrimitive), 'number');

  Parser coreToken() => ref(token, '@') & ref(variableName);

  Parser characterPrimitive() =>
      ref(characterNormal) | ref(characterEscape) | ref(characterUnicode);

  Parser characterNormal() => pattern('^"\\');

  Parser characterEscape() => char('\\') & pattern(jsonEscapeChars.keys.join());

  Parser characterUnicode() => string('\\u') & pattern('0-9A-Fa-f').times(4);

  Parser funcName() => characterNormal().times(2);

  Parser numberPrimitive() =>
      char('-').optional() &
      char('0').or(digit().plus()) &
      char('.').seq(digit().plus()).optional() &
      pattern('eE')
          .seq(pattern('-+').optional())
          .seq(digit().plus())
          .optional();

  Parser colorPrimitive() => char('#') & pattern('0-9A-Fa-f').times(8);

  Parser stringPrimitive() =>
      char('"') & ref(characterPrimitive).star() & char('"');

  Parser parameter() => ref(characterPrimitive).star();
}
