import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class TextStyleBox extends CompositeBox<TextStyle> with ComplexLayoutProvider {
  TextStyleBox([data = const {}])
      : fontSize = Prop(
          box: DoubleBox.value(data['fontSize'] ?? {}),
          name: 'FontSize',
          defaultValue: 20.0,
          type: PropType.value,
        ),
        color = Prop(
          box: ColorBox.dynamic(data['color'] ?? Colors.black),
          name: 'Color',
          defaultValue: Colors.black,
          type: PropType.value,
        ),
        fontWeight = Prop(
          box: FontWeightBox.dynamic(data['fontWeight'] ?? FontWeight.w400),
          name: 'FontWeight',
          defaultValue: FontWeight.w400,
          type: PropType.value,
        ),
        letterSpacing = Prop(
          box: DoubleBox.value(data['letterSpacing'] ?? {}),
          name: 'LetterSpacing',
          defaultValue: 0.0,
          type: PropType.fromData(data['letterSpacing']),
        ),
        wordSpacing = Prop(
          box: DoubleBox.value(data['wordSpacing'] ?? {}),
          name: 'WordSpacing',
          defaultValue: 0.0,
          type: PropType.fromData(data['wordSpacing']),
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
