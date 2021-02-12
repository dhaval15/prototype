part of 'fields.dart';

class BoolField extends StatelessWidget {
  final ValueChangeListener<bool> listener;
  final bool value;

  const BoolField({Key key, this.listener, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: Align(
        alignment: Alignment.centerRight,
        child: SwitchWidget(
          value: value,
          onChanged: (bool value) {
            listener(value);
          },
        ),
      ),
    );
  }
}
