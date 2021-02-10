import 'package:flutter/material.dart';

class FreezedContainer extends StatefulWidget {
  final Widget field;
  final bool freezed;

  const FreezedContainer({Key key, this.field, this.freezed}) : super(key: key);

  static FreezedContainerState of(BuildContext context) =>
      context.findAncestorStateOfType<FreezedContainerState>();

  @override
  FreezedContainerState createState() => FreezedContainerState();
}

class FreezedContainerState extends State<FreezedContainer> {
  bool freezed;
  void freeze() {
    setState(() {
      freezed = true;
    });
  }

  void redraw() {
    setState(() {});
  }

  void unfreeze() {
    setState(() {
      freezed = false;
    });
  }

  void hibernate() {
    // setState(() {
    //   freezed = null;
    // });
  }

  @override
  void initState() {
    super.initState();
    this.freezed = widget.freezed;
  }

  @override
  Widget build(BuildContext context) {
    return freezed == null
        ? IgnorePointer(
            ignoring: true,
            child: widget.field,
          )
        : freezed
            ? SizedBox(width: 0, height: 0)
            : widget.field;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
