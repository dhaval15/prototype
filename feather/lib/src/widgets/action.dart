import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

class ActionWidget extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;

  const ActionWidget({
    Key key,
    @override this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(icon),
      onTap: onTap,
    ).padding(all: 8);
  }
}
