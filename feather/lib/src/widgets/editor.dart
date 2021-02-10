import 'package:flutter/material.dart' hide TabBar;
import 'package:extras/extras.dart';

import 'widgets.dart';

class Editor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TabBar(
          tabs: [
            'Simple',
            'Advanced',
          ],
          selected: 'Simple',
        ),
      ],
    ).padding(all: 16);
  }
}
