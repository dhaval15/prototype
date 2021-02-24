part of 'fields.dart';

class ColorField extends StatefulWidget {
  final ValueChangeListener<Color> listener;
  final Color value;

  const ColorField({Key key, this.listener, this.value}) : super(key: key);

  @override
  _ColorFieldState createState() => _ColorFieldState();
}

class _ColorFieldState extends State<ColorField> {
  Color value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black87.withOpacity(0.5),
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(32),
                  color: value),
            ),
            SizedBox(width: 4),
            Text(value?.toReadableString() ?? ''),
          ],
        ),
      ),
      onTap: () async {
        final color = await _onEdit(context);
        if (color != null) {
          setState(() {
            this.value = color;
          });
          widget.listener(color);
        }
      },
    );
  }

  Future _onEdit(BuildContext context) =>
      ColorPickerDialog.show(context, color: value);
}
