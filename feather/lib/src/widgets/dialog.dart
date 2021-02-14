import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

class FancyDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final List<Widget> actions;
  final double width;
  final Color color;

  const FancyDialog({
    Key key,
    this.title,
    this.children,
    this.width,
    this.actions,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: color,
      contentPadding: EdgeInsets.all(24),
      title: Center(
        child: Text(title ?? ''),
      ),
      children: [
        ...children,
        if (actions != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: actions,
          ).centerRight().padding(top: 8),
      ],
    );
  }
}
