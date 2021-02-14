import 'package:feather/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

class CodeDialog extends StatelessWidget {
  const CodeDialog(this.code);

  static Future show(BuildContext context, String code) =>
      showDialog(context: context, builder: (context) => CodeDialog(code));

  final String code;

  @override
  Widget build(BuildContext context) {
    return FancyDialog(
      color: Color(0xFF282828),
      title: 'Code',
      children: [
        HighlightView(
          code,
          language: 'dart',
          tabSize: 2,
          theme: gruvboxDarkTheme,
          padding: EdgeInsets.all(12),
        ),
      ],
      actions: [
        FlatButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: code));
          },
          child: Text('Copy'),
        ),
      ],
    );
  }
}

const gruvboxDarkTheme = {
  'root':
      TextStyle(backgroundColor: Colors.transparent, color: Color(0xffebdbb2)),
  'subst': TextStyle(color: Color(0xffebdbb2)),
  'deletion': TextStyle(color: Color(0xfffb4934)),
  'formula': TextStyle(color: Color(0xfffb4934)),
  'keyword': TextStyle(color: Color(0xfffb4934)),
  'link': TextStyle(color: Color(0xfffb4934)),
  'selector-tag': TextStyle(color: Color(0xfffb4934)),
  'built_in': TextStyle(color: Color(0xff83a598)),
  'emphasis': TextStyle(color: Color(0xff83a598), fontStyle: FontStyle.italic),
  'name': TextStyle(color: Color(0xff83a598)),
  'quote': TextStyle(color: Color(0xff83a598)),
  'strong': TextStyle(color: Color(0xff83a598), fontWeight: FontWeight.bold),
  'title': TextStyle(color: Color(0xff83a598)),
  'variable': TextStyle(color: Color(0xff83a598)),
  'attr': TextStyle(color: Color(0xfffabd2f)),
  'params': TextStyle(color: Color(0xfffabd2f)),
  'template-tag': TextStyle(color: Color(0xfffabd2f)),
  'type': TextStyle(color: Color(0xfffabd2f)),
  'builtin-name': TextStyle(color: Color(0xff8f3f71)),
  'doctag': TextStyle(color: Color(0xff8f3f71)),
  'literal': TextStyle(color: Color(0xffd3869b)),
  'number': TextStyle(color: Color(0xffd3869b)),
  'code': TextStyle(color: Color(0xfffe8019)),
  'meta': TextStyle(color: Color(0xfffe8019)),
  'regexp': TextStyle(color: Color(0xfffe8019)),
  'selector-id': TextStyle(color: Color(0xfffe8019)),
  'template-variable': TextStyle(color: Color(0xfffe8019)),
  'addition': TextStyle(color: Color(0xffb8bb26)),
  'meta-string': TextStyle(color: Color(0xffb8bb26)),
  'section': TextStyle(color: Color(0xffb8bb26), fontWeight: FontWeight.bold),
  'selector-attr': TextStyle(color: Color(0xffb8bb26)),
  'selector-class': TextStyle(color: Color(0xffb8bb26)),
  'string': TextStyle(color: Color(0xffb8bb26)),
  'symbol': TextStyle(color: Color(0xffb8bb26)),
  'attribute': TextStyle(color: Color(0xff8ec07c)),
  'bullet': TextStyle(color: Color(0xff8ec07c)),
  'class': TextStyle(color: Color(0xff8ec07c)),
  'function': TextStyle(color: Color(0xff8ec07c)),
  'meta-keyword': TextStyle(color: Color(0xff8ec07c)),
  'selector-pseudo': TextStyle(color: Color(0xff8ec07c)),
  'tag': TextStyle(color: Color(0xff8ec07c), fontWeight: FontWeight.bold),
  'comment': TextStyle(color: Color(0xff928374), fontStyle: FontStyle.italic),
  'link_label': TextStyle(color: Color(0xffd3869b)),
};
