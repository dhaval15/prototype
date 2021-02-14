export 'package:box/box.dart';
export 'package:flutter_box/flutter_box.dart';
export 'package:lambda/lambda.dart';
export 'package:fountain/fountain.dart';
export 'package:select/select.dart';
export 'registry.dart';

import 'package:box/box.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flutter_box/flutter_box.dart';
import 'package:lambda/lambda.dart';
import 'package:fountain/fountain.dart';
import 'package:select/select.dart';
import 'registry.dart';

part 'utils.dart';

class Framework {
  static Future init() => _init();

  static String generateCode(BoxMixin box, {String label = 'Output'}) {
    final code = _generateCode(box, label: label);
    return DartFormatter().format(code);
  }

  static Future<void> saveAsJson(BoxMixin box) async {
    final json = _generateJson(box);
    print(json);
  }
}
