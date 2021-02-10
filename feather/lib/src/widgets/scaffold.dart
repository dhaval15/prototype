import 'dart:io';
import 'package:extras/extras.dart';
import 'package:flutter/material.dart';

class PrototypeScaffold extends StatelessWidget {
  final Widget tree, view, editor;
  final String title;
  final Color backgroundColor;

  const PrototypeScaffold({
    Key key,
    this.tree,
    this.view,
    this.editor,
    this.title,
    this.backgroundColor,
  }) : super(key: key);

  Widget buildHorizontal(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  tree,
                  Container(
                    width: 1,
                    color: context.foreground.withOpacity(0.2),
                  ),
                  view,
                  Container(
                    width: 1,
                    color: context.foreground.withOpacity(0.2),
                  ),
                  editor,
                ],
              ).expand(),
            ],
          ),
        ),
      );

  Widget buildVertical(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              view,
              editor,
            ],
          ),
        ),
        drawer: Drawer(
          child: tree,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var platform;
    try {
      platform = Platform.operatingSystem;
    } catch (_) {
      platform = 'web';
    }
    switch (platform) {
      case 'ios':
        return buildVertical(context);
      case 'linux':
      case 'web':
      case 'windows':
      case 'android':
        return buildHorizontal(context);
    }
    throw 'Unsupported Platform : ${Platform.operatingSystem}';
  }
}
