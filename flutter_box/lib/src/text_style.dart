import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class TextStyleBox extends CompositeBox<TextStyle> with ComplexLayoutProvider {
  TextStyleBox({data = const {}, MultiBox parent})
      : fontSize = Prop(
          box: DoubleBox.dynamic(data: data['fontSize'] ?? 20.0),
          name: 'FontSize',
          defaultValue: 20.0,
          type: PropType.value,
        ),
        color = Prop(
          box: ColorBox.dynamic(data: data['color'] ?? Colors.black),
          name: 'Color',
          defaultValue: Colors.black,
          type: PropType.value,
        ),
        fontWeight = Prop(
          box: FontWeightBox.dynamic(
              data: data['fontWeight'] ?? FontWeight.w400),
          name: 'FontWeight',
          defaultValue: FontWeight.w400,
          type: PropType.value,
        ),
        letterSpacing = Prop(
          box: DoubleBox.dynamic(data: data['letterSpacing'] ?? 0.0),
          name: 'LetterSpacing',
          defaultValue: 0.0,
          type: PropType.fromData(data['letterSpacing']),
        ),
        wordSpacing = Prop(
          box: DoubleBox.dynamic(data: data['wordSpacing'] ?? 0.0),
          name: 'WordSpacing',
          defaultValue: 0.0,
          type: PropType.fromData(data['wordSpacing']),
        ),
        super(parent: parent);

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

  @override
  String get boxType => 'TextStyle';
}
