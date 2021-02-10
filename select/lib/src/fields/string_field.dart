part of 'fields.dart';

class StringField extends StatelessWidget {
  final ValueChangeListener<String> listener;
  final StringController controller;

  const StringField({Key key, this.listener, this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      selectionHeightStyle: BoxHeightStyle.tight,
      style: TextStyle(fontSize: 13),
      decoration: _INPUT_DECORATION,
      cursorWidth: 1,
      cursorColor: context.foreground,
      onChanged: listener,
    );
  }
}
