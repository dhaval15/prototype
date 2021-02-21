import 'package:feather/src/framework/framework.dart';
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

  static Future<Workspace> load() async {
    final data = await Framework.loadBoxFromFile();
    final label = data[0];
    final box = data[1];
    return Workspace._(
        label,
        EditorScreen(
          key: UniqueKey(),
          box: box,
          label: label,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return screen;
  }
}
