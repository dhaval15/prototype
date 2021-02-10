import 'package:flutter/material.dart';
import 'package:box/box.dart';

class TextBox extends CompositeBox<Text> with ListViewLayoutMixin {
  TextBox([data = const {}])
      : text = Prop(
          box: StringBox.dynamic(data['#0'] ?? 'Hello'),
          label: 'Text',
          defaultValue: 'Hello',
          type: PropType.permanant,
          index: 0,
        ),
        style = Prop(
          box: TextStyleBox(data['style'] ?? {}),
          label: 'Style',
          type: propType(data['style']),
        ),
        textAlign = Prop(
          box: TextAlignBox.dynamic(data['textAlign'] ?? TextAlign.start),
          label: 'TextAlign',
          defaultValue: TextAlign.start,
          type: propType(data['textAlign']),
        ),
        super();

  final Prop text, style, textAlign;

  @override
  List<Prop> get props => [text, style, textAlign];

  @override
  Text get value => Text(
        text.value,
        style: style.value,
        textAlign: textAlign.value,
      );
}
