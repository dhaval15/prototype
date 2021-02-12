import 'package:flutter/material.dart';

class IntController extends TextEditingController {
  IntController(int value) : super(text: value?.toString() ?? '');
  set intValue(int value) {
    this.text = value.toString();
  }

  int get intValue => int.tryParse(this.text);
}

class DoubleController extends TextEditingController {
  DoubleController(double value)
      : super(text: value?.truncate()?.toString() ?? '');

  set doubleValue(double value) {
    this.text = value.truncate().toString();
  }

  double get doubleValue => double.tryParse(this.text);
}

class StringController extends TextEditingController {
  StringController(String value) : super(text: value?.toString() ?? '');

  set stringValue(String value) {
    this.text = value;
  }

  String get stringValue => value.text;
}
