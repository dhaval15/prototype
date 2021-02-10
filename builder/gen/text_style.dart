import 'package:flutter/material.dart';
import 'package:box/box.dart';

class TextStyleBox extends CompositeBox<TextStyle> with ComplexLayoutMixin {
  TextStyleBox([data = const {}])
      : fontSize = Prop(
          box: DoubleBox.value(data['fontSize'] ?? 20.0),
          label: 'FontSize',
          defaultValue: 20.0,
          type: PropType.permanant,
        ),
        color = Prop(
          box: ColorBox.dynamic(data['color'] ?? Colors.black),
          label: 'Color',
          defaultValue: Colors.black,
          type: PropType.permanant,
        ),
        fontWeight = Prop(
          box: FontWeightBox.dynamic(data['fontWeight'] ?? FontWeight.w400),
          label: 'FontWeight',
          defaultValue: FontWeight.w400,
          type: PropType.permanant,
        ),
        letterSpacing = Prop(
          box: DoubleBox.value(data['letterSpacing'] ?? 0.0),
          label: 'LetterSpacing',
          defaultValue: 0.0,
          type: propType(data['letterSpacing']),
        ),
        wordSpacing = Prop(
          box: DoubleBox.value(data['wordSpacing'] ?? 0.0),
          label: 'WordSpacing',
          defaultValue: 0.0,
          type: propType(data['wordSpacing']),
        ),
        super();

  final Prop fontSize, color, fontWeight, letterSpacing, wordSpacing;

  @override
  List<Prop> get props =>
      [fontSize, color, fontWeight, letterSpacing, wordSpacing];

  @override
  TextStyle get value => TextStyle(
        fontSize: fontSize.value,
        color: color.value,
        fontWeight: fontWeight.value,
        letterSpacing: letterSpacing.value,
        wordSpacing: wordSpacing.value,
      );
}
