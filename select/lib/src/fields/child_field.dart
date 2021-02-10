part of 'fields.dart';

mixin ChildMixin {
  Widget get value;
  set value(value);
}

mixin ChildGenerator {
  List<String> get widgets;
  widget(String type);
}

class ChildField extends StatefulWidget {
  static ChildGenerator generator;
  final ValueChangeListener<BuildContext> listener;
  final Widget value;
  final ChildMixin child;

  const ChildField({Key key, this.listener, this.value, this.child})
      : super(key: key);

  @override
  _ChildFieldState createState() => _ChildFieldState();
}

class _ChildFieldState extends State<ChildField> {
  String type;
  @override
  void initState() {
    super.initState();
    type = widget.child.toType() ?? 'Select';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(type),
            ),
            onTap: () async {
              if (widget.child.isEmpty()) {
                final type = await showDialog(
                  context: context,
                  builder: (context) => WidgetsDialog(),
                );
                if (type != null) {
                  final box = ChildField.generator.widget(type)();
                  setState(() {
                    this.type = type;
                  });
                  widget.child.value = box;
                  widget.listener(context);
                }
              } else {
                widget.listener(context);
              }
            }).expand(),
        GestureDetector(
          child: Icon(
            Icons.delete,
            size: 20,
          ).padding(all: 6),
          onTap: () {
            widget.child.value = null;
            setState(() {
              type = 'Select';
            });
          },
        ),
      ],
    );
  }
}

class WidgetsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widgets = ChildField.generator.widgets;
    return Dialog(
      child: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          final name = widgets[index];
          return ListTile(
            title: Text(name),
            onTap: () {
              Navigator.of(context).pop(name);
            },
          );
        },
      ),
    );
  }
}

extension on ChildMixin {
  bool isEmpty() {
    return value == null;
  }

  String toType() {
    return value?.runtimeType?.toString();
  }
}
