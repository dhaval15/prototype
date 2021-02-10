import 'package:box/src/mixins/mixins.dart';
import 'package:flutter/material.dart';

mixin FontWeightProvider implements OptionsProvider<FontWeight> {
  Map<String, FontWeight> get options => {
        'w100': FontWeight.w100,
        'w200': FontWeight.w200,
        'w300': FontWeight.w300,
        'w400': FontWeight.w400,
        'w500': FontWeight.w500,
        'w600': FontWeight.w600,
        'w700': FontWeight.w700,
        'w800': FontWeight.w800,
        'w900': FontWeight.w900,
      };
}

mixin TextAlignProvider implements OptionsProvider<TextAlign> {
  Map<String, TextAlign> get options => {
        'left': TextAlign.left,
        'right': TextAlign.right,
        'center': TextAlign.center,
        'justify': TextAlign.justify,
        'start': TextAlign.start,
        'end': TextAlign.end,
      };
}

mixin MainAxisAlignmentProvider implements OptionsProvider<MainAxisAlignment> {
  Map<String, MainAxisAlignment> get options => {
        'start': MainAxisAlignment.start,
        'end': MainAxisAlignment.end,
        'center': MainAxisAlignment.center,
        'spaceBetween': MainAxisAlignment.spaceBetween,
        'spaceAround': MainAxisAlignment.spaceAround,
        'spaceEvenly': MainAxisAlignment.spaceEvenly,
      };
}

mixin CrossAxisAlignmentProvider
    implements OptionsProvider<CrossAxisAlignment> {
  Map<String, CrossAxisAlignment> get options => {
        'start': CrossAxisAlignment.start,
        'end': CrossAxisAlignment.end,
        'center': CrossAxisAlignment.center,
        'stretch': CrossAxisAlignment.stretch,
        'baseline': CrossAxisAlignment.baseline,
      };
}

mixin MainAxisSizeProvider implements OptionsProvider<MainAxisSize> {
  Map<String, MainAxisSize> get options => {
        'min': MainAxisSize.min,
        'max': MainAxisSize.max,
      };
}

mixin VerticalDirectionProvider implements OptionsProvider<VerticalDirection> {
  Map<String, VerticalDirection> get options => {
        'up': VerticalDirection.up,
        'down': VerticalDirection.down,
      };
}

mixin FontStyleProvider implements OptionsProvider<FontStyle> {
  Map<String, FontStyle> get options => {
        'normal': FontStyle.normal,
        'italic': FontStyle.italic,
      };
}
