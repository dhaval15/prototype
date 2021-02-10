import 'dart:convert';
import 'dart:io';

import 'parsers.dart';

void main() async {
  final text =
      await File('/home/dhaval/Workspace/parsers/card.scene').readAsString();
  print(text);
  final result = Spec2Parser().parse(text);
  print(JsonEncoder.withIndent('  ').convert(result.value));
}
