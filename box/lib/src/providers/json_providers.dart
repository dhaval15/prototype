import 'package:box/box.dart';
import 'package:flutter/material.dart';

mixin ColorJsonProvider on CoreBox<Color> implements JsonMixin {
  @override
  get json => value.value;
}

mixin OptionJsonProvider<T> on CoreBox<T> implements JsonMixin {
  @override
  get json => value.toString().split('.')[1];
}
