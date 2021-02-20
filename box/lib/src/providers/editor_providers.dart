import 'package:box/box.dart';
import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

mixin SimpleEditorProvider implements EditorProvider {
  @override
  Widget buildEditor(Prop prop) => Row(
        children: [
          prop.label.restrict(width: 100),
          Container(
            color: Colors.white.withAlpha(40),
            child: prop.field,
          ).expand(),
          ...prop.actions
              .map((w) => w.color(color: Colors.white.withAlpha(40))),
        ],
      );
}
mixin RowEditorProvider implements EditorProvider {
  @override
  Widget buildEditor(Prop prop) => Row(
        children: [
          prop.label.restrict(width: 100),
          prop.field.expand(),
        ],
      );
}

mixin ComplexEditorProvider implements EditorProvider {
  @override
  Widget buildEditor(Prop prop) => ComplexView(prop: prop);
}

mixin AbstractEditorProvider implements EditorProvider {
  @override
  Widget buildEditor(Prop prop) => AbstractView(prop: prop);
}

class AbstractView extends StatefulWidget {
  final Prop prop;

  const AbstractView({Key key, this.prop}) : super(key: key);

  @override
  _AbstractViewState createState() => _AbstractViewState();
}

class _AbstractViewState extends State<AbstractView> {
  @override
  Widget build(BuildContext context) {
    final box = widget.prop.box as AbstractBox;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            widget.prop.label,
            SizedBox(width: 8),
            Expanded(
              child: Dropdown<String>(
                controller: ValueNotifier<String>(box.currentType),
                items: box.inheritedTypes,
                selectedItembuilder: (text) => Text(text),
                itemBuilder: (text) => Text(text),
                onChanged: (type) async {
                  box.setInherited(type);
                  await Future.delayed(Duration(milliseconds: 1));
                  setState(() {});
                },
              ),
            ),
            AddPropAction(box.props),
            ...widget.prop.actions,
          ],
        ),
        Divider(),
        widget.prop.field.padding(left: 8),
      ],
    );
  }
}

class ComplexView extends StatefulWidget {
  final Prop prop;

  const ComplexView({Key key, this.prop}) : super(key: key);

  @override
  _ComplexViewState createState() => _ComplexViewState();
}

class _ComplexViewState extends State<ComplexView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            widget.prop.label,
            SizedBox().expand(),
            if (widget.prop.box is BaseMultiBox) AddAction(onAddBox),
            if (widget.prop.box is PropsProvider)
              AddPropAction((widget.prop.box as PropsProvider).props),
            ...widget.prop.actions,
          ],
        ),
        Divider(),
        widget.prop.field.padding(left: 8),
      ],
    );
  }

  void onAddBox() async {
    await (widget.prop.box as BaseMultiBox).append();
    setState(() {});
  }
}

class ScopeView extends StatefulWidget {
  final Prop prop;
  final WidgetBuilder field;

  const ScopeView({Key key, this.prop, this.field}) : super(key: key);

  @override
  _ScopeViewState createState() => _ScopeViewState();
}

class _ScopeViewState extends State<ScopeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            widget.prop.label,
            SizedBox().expand(),
            AddAction(onAddParam),
            ...widget.prop.actions,
          ],
        ),
        widget.field(context),
      ],
    );
  }

  void onAddParam() async {
    final name = await showDialog(
        context: context, builder: (context) => PropNameDialog());
    if (name == null) return;
    final type = await showDialog(
        context: context,
        builder: (context) => PropTypesDialog(types: ScopeBox.generator.types));
    if (type == null) return;
    final box = ScopeBox.generator.any(type)();
    await box.execute();
    await (widget.prop.box as ScopeBox).addParam(name, box);
    setState(() {});
  }
}

class PropTypesDialog extends StatelessWidget {
  final List<String> types;

  const PropTypesDialog({Key key, this.types}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: types.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(types[index]),
            onTap: () {
              Navigator.of(context).pop(types[index]);
            },
          ),
        ),
      ),
    );
  }
}

class PropNameDialog extends StatelessWidget {
  const PropNameDialog({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Dialog(
      child: SizedBox(
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            FlatButton(
              child: Text('Add'),
              onPressed: () {
                final text = controller.text;
                if (text.isNotEmpty) Navigator.of(context).pop(text);
              },
            )
          ],
        ),
      ),
    );
  }
}
