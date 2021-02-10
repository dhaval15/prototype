import 'dart:ui';
import 'package:extras/extras.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

part 'string_field.dart';
part 'int_field.dart';
part 'double_field.dart';
part 'color_field.dart';
part 'option_field.dart';
part 'child_field.dart';

typedef ValueChangeListener<T> = void Function(T value);

const _INPUT_DECORATION = InputDecoration(
  border: InputBorder.none,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  isCollapsed: true,
  isDense: true,
  contentPadding: EdgeInsets.all(8),
);
