import 'package:flutter/material.dart';

import 'box.dart';
import 'boxes.dart';
import '../widgets/widgets.dart';

abstract class WidgetBox<T extends Widget> = CompositeBox<Widget>
    with WidgetProvider<T>;

mixin WidgetProvider<T extends Widget> on CompositeBox<Widget> {
  T get widget;
  final CoreBox<bool> _guideBox = CoreBox.value(true);

  void enableGuideline() {
    _guideBox.update(true);
  }

  void disableGuideline() {
    _guideBox.update(false);
  }

  Widget get value {
    return _guideBox.boxedValue ? Guideline(widget) : widget;
  }

  @override
  List get params {
    final list = [];
    list.add(_guideBox);
    props.forEach((prop) {
      list.add(prop.box);
    });
    return list;
  }
}

class Guideline extends StatefulWidget {
  final Widget child;
  static _GuidelineState _guideState;

  const Guideline(this.child) : super();

  static void toggle() {
    _guideState.toggle();
  }

  @override
  _GuidelineState createState() {
    _guideState = _GuidelineState();
    return _guideState;
  }

  // @override
  // Type get runtimeType => child?.runtimeType;
}

class _GuidelineState extends State<Guideline> {
  static bool _guideline = true;
  void toggle() {
    setState(() {
      _guideline = !_guideline;
    });
  }

  Widget build(BuildContext context) {
    return _guideline
        ? DashedRect(
            strokeWidth: 1,
            child: widget.child,
            color: Colors.yellow,
          )
        : widget.child;
  }
}
