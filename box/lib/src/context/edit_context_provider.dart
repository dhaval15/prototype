import 'dart:async';

import 'package:box/box.dart';
import 'package:box/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditContextProvider extends StatefulWidget {
  final Widget child;
  final bool allowBack;

  const EditContextProvider({Key key, this.child, this.allowBack = false})
      : super(key: key);

  static EditContext of(BuildContext context) =>
      context.findAncestorStateOfType<EditContextProviderState>().editContext;

  @override
  EditContextProviderState createState() => EditContextProviderState();
}

class EditContextProviderState extends State<EditContextProvider> {
  final editContext = EditContext();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => editContext.back(),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    editContext.dispose();
    super.dispose();
  }
}

class EditContext {
  static EditContext of(BuildContext context) =>
      context.findAncestorStateOfType<EditContextProviderState>().editContext;

  final List<Prop> _list = [];
  final _editorController = StreamController<Widget>();
  final _treeController = StreamController<int>();

  Stream<Widget> get editorStream => _editorController.stream;
  Stream<int> get treeStream => _treeController.stream;

  Prop get current => _list.last;
  CompositeBox<Widget> get currentBox => current.box;

  void updateTree() {
    _treeController.add(0);
  }

  T findAncestorBoxOfType<T>() {
    int index = _list.length - 1;
    while (index > -1) {
      final prop = _list[index];
      if (prop.box is T) return prop.box as T;
      index--;
    }
    return null;
  }

  set current(Prop prop) {
    if (_list.isNotEmpty) (_list.last.box as WidgetBox).disableGuideline();
    if (prop.box is WidgetBox) {
      (prop.box as WidgetBox).enableGuideline();
    }
    _list.add(prop);
    _editorController.add(prop.field);
  }

  bool back() {
    if (_list.length <= 1) return true;
    final last = _list.removeLast().box;
    if (last is WidgetBox) {
      last.disableGuideline();
    }
    final parent = _list.last;
    (parent.box as WidgetBox).enableGuideline();
    _editorController.add(parent.field);
    return false;
  }

  Future showAddPropsDialog(BuildContext context) async {
    final prop = await PropsDialog.show(
      context,
      currentBox.props.where((prop) => prop.type == null).toList(),
    );
    prop.enable();
  }

  void dispose() {
    _editorController.close();
    _treeController.close();
  }
}

class Node {
  final String name;
  final int index;

  Node({
    this.name,
    this.index,
  });
}
