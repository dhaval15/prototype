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

  Future _onEdit(BuildContext context) => showDialog(
        context: context,
        child: _ColorPickerDialog(
          color: value ?? Colors.white,
        ),
      );
}

class _ColorPickerDialog extends StatefulWidget {
  final Color color;

  const _ColorPickerDialog({Key key, this.color = Colors.white})
      : super(key: key);

  @override
  __ColorPickerDialogState createState() => __ColorPickerDialogState();
}

class __ColorPickerDialogState extends State<_ColorPickerDialog> {
  Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _color,
          onColorChanged: (color) {
            _color = color;
          },
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Select'),
          onPressed: () {
            Navigator.of(context).pop(_color);
          },
        ),
      ],
    );
  }
}
