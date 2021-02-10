import 'package:flutter/material.dart';
import 'package:box/box.dart';
import 'flutter_box.dart';

class TextBox extends WidgetBox<Widget> with ListViewLayoutProvider {
  TextBox([data = const {}])
      : text = Prop(
          box: StringBox.dynamic(data['#0'] ?? 'Hello'),
          name: 'Text',
          defaultValue: 'Hello',
          type: PropType.value,
          index: 0,
        ),
        style = Prop(
          box: TextStyleBox(data['style'] ?? {}),
          name: 'Style',
          type: PropType.value,
        ),
        textAlign = Prop(
          box: TextAlignBox.dynamic(data['textAlign'] ?? TextAlign.start),
          name: 'TextAlign',
          defaultValue: TextAlign.start,
          type: PropType.fromData(data['textAlign']),
        ),
        super();

  final Prop text, style, textAlign;

  @override
  List<Prop> get props => [text, style, textAlign];

  @override
  Text get widget => Text(
        text.value,
        style: style.value,
        textAlign: textAlign.value,
      );
}
