import 'dart:io';
import 'package:extras/extras.dart';
import 'package:flutter/material.dart';

class PrototypeScaffold extends StatelessWidget {
  final Widget tree, view, editor;
  final String title;
  final Color backgroundColor;
  final List<Widget> actions;
  final Widget leading;

  const PrototypeScaffold({
    Key key,
    this.tree,
    this.view,
    this.editor,
    this.title,
    this.backgroundColor,
    this.actions,
    this.leading,
  }) : super(key: key);

  Widget buildHorizontal(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              AppBarView(
                title: title,
                actions: actions,
                leading: leading,
              ),
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

class AppBarView extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget leading;

  const AppBarView({
    Key key,
    this.title,
    this.actions,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 36,
      color: context.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leading != null) leading,
          Text(title, style: context.headline6),
          if (actions != null)
            Row(mainAxisSize: MainAxisSize.min, children: actions),
        ],
      ).padding(horizontal: 16),
    );
  }
}
