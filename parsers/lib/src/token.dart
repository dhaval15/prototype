import 'package:petitparser/petitparser.dart';

extension P on Iterable<Parser<dynamic>> {
  Parser toParser() {
    Parser p = this.iterator.current;
    while (this.iterator.moveNext()) {
      p = p | this.iterator.current;
    }
    return p;
  }
}

mixin TokenMixin on GrammarDefinition {
  Parser runtime();

  Parser start() => ref(runtime).end();

  Parser token(Object source, [String name]) {
    Parser parser;
    String expected;
    if (source is String) {
      if (source.length == 1) {
        parser = char(source);
      } else {
        parser = string(source);
      }
      expected = name ?? source;
    } else if (source is Parser) {
      parser = source;
      expected = name;
    } else {
      throw ArgumentError('Unknown token type: $source.');
    }
    if (expected == null) {
      throw ArgumentError('Missing token name: $source');
    }
    return parser.flatten(expected).trim();
  }
}

dynamic toNum(String s) {
  final doubleValue = double.parse(s);
  final intValue = doubleValue.toInt();
  if (intValue - doubleValue == 0) {
    return intValue;
  } else {
    return doubleValue;
  }
}
