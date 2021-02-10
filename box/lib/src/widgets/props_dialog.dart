import 'package:box/box.dart';
import 'package:flutter/material.dart';

class PropsDialog extends StatelessWidget {
  final List<Prop> props;

  const PropsDialog({Key key, this.props}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: props.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(props[index].name),
          onTap: () {
            props[index].enable();
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
