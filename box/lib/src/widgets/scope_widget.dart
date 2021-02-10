import 'package:flutter/material.dart';

class Scope extends StatelessWidget {
  final Widget child;

  factory Scope.of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<Scope>();

  const Scope({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child ?? SizedBox();
  }
}
