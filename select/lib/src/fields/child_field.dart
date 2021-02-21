part of 'fields.dart';

mixin ChildMixin {
  get box;
  Widget get value;
  set value(value);
}

mixin ChildGenerator {
  List<String> get widgets;
  widget(String type);
}

abstract class ChildEvent {}

class ChildAddEvent extends ChildEvent {
  final BuildContext context;

  ChildAddEvent(this.context);
}

class ChildToEvent extends ChildEvent {
  final BuildContext context;

  ChildToEvent(this.context);
}

class ChildDeleteEvent extends ChildEvent {
  final BuildContext context;

  ChildDeleteEvent(this.context);
}

class ChildField extends StatefulWidget {
  static ChildGenerator generator;
  final ValueChangeListener<ChildEvent> listener;
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
    type = widget.child.box?.boxType ?? 'Select';
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
              if (widget.child.value == null) {
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
                  widget.listener(ChildAddEvent(context));
                }
              } else {
                widget.listener(ChildToEvent(context));
              }
            }).expand(),
        GestureDetector(
          child: Icon(
            Icons.delete,
            size: 20,
          ).padding(all: 6),
          onTap: () {
            widget.child.value = null;
            widget.listener(ChildDeleteEvent(context));
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
    return SimpleDialog(
      title: Text('Pick a Widget'),
      children: List.generate(
        widgets.length,
        (index) {
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
