import 'package:box/box.dart';
import 'package:flutter/material.dart';

class PropsDialog extends StatelessWidget {
  final List<Prop> props;

  static Future<Prop> show(BuildContext context, List<Prop> props) {
    if (props.isEmpty) return null;
    return showDialog(
        context: context,
        builder: (context) => PropsDialog._(
              props: props,
            ));
  }

  const PropsDialog._({Key key, this.props}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Select a property to add'),
      children: List.generate(props.length, (int index) {
        return ListTile(
          title: Text(props[index].name),
          onTap: () {
            final prop = props[index];
            Navigator.of(context).pop(prop);
          },
        );
      }),
    );
  }
}
