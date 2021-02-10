import 'package:flutter/material.dart';
import 'package:select/select.dart';

import 'mixins.dart';
import 'prop_type.dart';

abstract class PropMixin<T> {
  int get index;
  GlobalKey<FreezedContainerState> get key;
  String get name;
  BoxMixin<T> get box;
  T get defaultValue;
  PropType get type;
  set type(PropType type);
  T get value;
  set value(value) {
    box.value = value;
  }
}
