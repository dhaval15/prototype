import 'base.dart';
import 'package:flutter/material.dart';

mixin FontWeight implements OptionsProviderMixin<FontWeight> {
  Map<String, FontWeight> get options => {
        'w100': FontWeight.w100,
        'w200': FontWeight.w200,
        'w300': FontWeight.w300,
        'w400': FontWeight.w400,
        'w500': FontWeight.w500,
        'w600': FontWeight.w600,
        'w700': FontWeight.w700,
        'w800': FontWeight.w800,
        'w900': FontWeight.w900
      };
}
