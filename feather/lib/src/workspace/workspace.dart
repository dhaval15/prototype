import 'package:flutter/material.dart';

import '../screens/screens.dart';

class Workspace extends StatelessWidget {
  final String label;
  final EditorScreen screen;

  Workspace._(this.label, this.screen);

  factory Workspace.create(String label) => Workspace._(
      label,
      EditorScreen(
        key: UniqueKey(),
        label: label,
      ));

  @override
  Widget build(BuildContext context) {
    return screen;
  }
}
