import 'package:box/src/mixins/mixins.dart';
import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

mixin ColorConverter implements ConverterMixin<Color> {
  Color convert(value) {
    if (value == null) return null;
    if (value is MaterialColor) return Color(value.value);
    if (value is Color) return value;
    if (value is int) return Color(value);
    if (value is String)
      try {
        return value.color;
      } catch (e) {
        throw '\'$value\' is not properly formated Color for eg. \'#RRGGBBOO\'';
      }
    throw 'Color should be String or Color';
  }
}

mixin DoubleConverter implements ConverterMixin<double> {
  double convert(value) => convertIt(value);
  static double convertIt(value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}

mixin BoolConverter implements ConverterMixin<bool> {
  bool convert(value) => convertIt(value);
  static bool convertIt(value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String)
      return value == 'true'
          ? true
          : value == 'false'
              ? false
              : null;
    return null;
  }
}

mixin RadiusConverter implements ConverterMixin<Radius> {
  Radius convert(value) {
    final doubleValue = DoubleConverter.convertIt(value);
    if (doubleValue != null) return Radius.circular(doubleValue);
    return null;
  }
}

mixin IntConverter implements ConverterMixin<int> {
  int convert(value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String)
      try {
        return int.parse(value);
      } catch (e) {
        throw '\'$value\' is not properly formated int';
      }
    throw 'Invalid int';
  }
}

mixin OptionConverter<T> on OptionsProvider<T> implements ConverterMixin<T> {
  @override
  T convert(value) {
    if (value == null) return null;
    if (value is T) return value;
    if (value is String) return options[value];
    throw 'value is type of ${value.runtimeType},it must be a string';
  }
}
