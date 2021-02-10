part of 'fields.dart';

class IntField extends StatelessWidget {
  final ValueChangeListener<int> listener;
  final IntController controller;

  const IntField({Key key, this.listener, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      selectionHeightStyle: BoxHeightStyle.includeLineSpacingMiddle,
      style: TextStyle(fontSize: 13),
      decoration: _INPUT_DECORATION,
      cursorWidth: 1,
      cursorColor: context.foreground,
      keyboardType: TextInputType.number,
      onChanged: (text) {
        final value = int.tryParse(text);
        listener(value);
      },
    );
  }
}
