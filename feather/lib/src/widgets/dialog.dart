import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

class FancyDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final List<Widget> actions;
  final double width;

  const FancyDialog({
    Key key,
    this.title,
    this.children,
    this.width,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: width,
        padding: EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            if (title != null)
              Text(
                title,
                style: context.headline5,
              ).center().padding(bottom: 8),
            ...children,
            if (actions != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ).centerRight().padding(top: 8),
          ],
        ),
      ),
    );
  }
}
