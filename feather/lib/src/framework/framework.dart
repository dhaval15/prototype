export 'package:box/box.dart';
export 'package:flutter_box/flutter_box.dart';
export 'package:lambda/lambda.dart';
export 'package:fountain/fountain.dart';
export 'package:select/select.dart';
export 'registry.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:box/box.dart';
import 'package:dart_style/dart_style.dart';
import 'package:file_utils/file_utils.dart';
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

  static Future<void> saveAsJson(BoxMixin box, String name) async {
    final map = {
      'label': name,
      'box': _generateJson(box),
    };
    final data = JsonEncoder.withIndent('  ').convert(map);
    await FileUtils().save('/home/dhaval/Feather/$name.json', data);
  }

  static Future<List> loadBoxFromFile() async {
    final data = await FileUtils().load();
    final map = JsonDecoder().convert(data);
    return [
      map['label'],
      _loadBoxFromJson(map['box']),
    ];
  }
}
