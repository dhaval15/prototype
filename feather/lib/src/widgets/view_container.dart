import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

import 'widgets.dart';

class ViewContainer extends StatefulWidget {
  final Widget child;
  final List<ActionWidget> actions;

  const ViewContainer({Key key, this.child, this.actions}) : super(key: key);
  @override
  _ViewContainerState createState() => _ViewContainerState();
}

class _ViewContainerState extends State<ViewContainer> {
  Size size = Size(720.0, 1280.0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...widget.actions,
            ActionWidget(
              icon: Icons.edit_rounded,
              onTap: () async {
                final size = await showDialog(
                    context: context,
                    builder: (context) => ChangeSizeDialog(
                          size: this.size,
                        ));
                if (size != null) {
                  setState(() {
                    this.size = size;
                  });
                }
              },
            ),
          ],
        ).padding(all: 16).topRight(),
        AspectRatio(
          aspectRatio: size.aspectRatio,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: MediaQuery(
              data: MediaQueryData(
                size: size,
              ),
              child: widget.child,
            ),
            decoration: BoxDecoration(
              // border: Border.all(width: 1, color: context.primary),
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Color(0x34000000),
                  blurRadius: 16,
                  spreadRadius: 2,
                  offset: Offset(4, 4),
                ),
              ],
            ),
          ),
        ).center().expand(),
        SizedBox(height: 16),
      ],
    );
  }
}

class ChangeSizeDialog extends StatelessWidget {
  final Size size;

  const ChangeSizeDialog({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final widthController =
        TextEditingController(text: size.width.toInt().toString());
    final heightController =
        TextEditingController(text: size.height.toInt().toString());
    return FancyDialog(
      width: 320,
      title: 'Change Size',
      children: [
        TextField(
          controller: widthController,
        ),
        TextField(
          controller: heightController,
        ),
      ],
      actions: [
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Change'),
          onPressed: () {
            final width = double.tryParse(widthController.text);
            final height = double.tryParse(heightController.text);
            if (width != null && height != null && width != 0 && height != 0) {
              Navigator.of(context).pop(Size(width, height));
            }
          },
        ),
      ],
    );
  }
}
