import 'dart:async';

import 'package:box/box.dart';
import 'package:box/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:select/select.dart';

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

  void drop() {
    if (_list.length > 1) {
      final child = _list.removeLast().box as WidgetBox;
      final parent = _list.last.box as WidgetBox;
      final childProp = child.props.firstWhere((prop) => prop.box is ChildBox);
      final parentBox = parent.props.firstWhere((prop) => prop.box is ChildBox);
      final json = JsonEngine.encode(childProp.box);
      final newBox = JsonEngine.decode(json);
      parentBox.box.value = null;
      parentBox.box.value = newBox;
      updateTree();
      _editorController.add(_list.last.field);
    }
  }

  void wrap(BuildContext context) async {
    if (_list.length > 1) {
      final child = _list.removeLast();
      final parent = _list.last.box as WidgetBox;
      final parentBox = parent.props.firstWhere((prop) => prop.box is ChildBox);
      parentBox.box.value = null;
      final wrappedBox = await _newWrappedBox(context, child);
      _list.add(Prop.onlyBox(wrappedBox));
      parentBox.box.value = wrappedBox;
      updateTree();
      _editorController.add(_list.last.field);
    }
  }

  Future<WidgetBox> _newWrappedBox(BuildContext context, Prop prop) async {
    final type = await WidgetsDialog.show(context);
    if (type != null) {
      WidgetBox newBox = ChildField.generator.widget(type)();
      await newBox.execute();
      final childBox = newBox.props
          .firstWhere((prop) => prop.box is ChildBox)
          .box as ChildBox;
      childBox.box = JsonEngine.copy(prop.box);
      print(JsonEngine.encode(newBox));
      return JsonEngine.copy(newBox);
    }
    return null;
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

  void jump(List<int> indices) {
    print('Intial State : ${_list.length} : $indices');
    if (indices.length >= _list.length) {
      _forward(indices);
    } else
      _backward(_list.length - indices.length, indices.last);
  }

  void _sideward(int index) {
    if (_list.length == 1) {
      (_list.last.box as WidgetBox).enableGuideline();
      _editorController.add(_list.last.field);
    } else {
      (_list.removeLast().box as WidgetBox).disableGuideline();
      final parent = _list.last;
      WidgetBox next = parent.box;
      _list.add(parent);
      final children = <WidgetBox>[
        ...next.props
            .where((prop) => prop.box is ChildBox)
            .map((prop) => (prop.box as ChildBox).box),
        ...next.props
            .where((prop) => prop.box is ChildrenBox)
            .map((prop) => (prop.box as ChildrenBox)
                .boxes
                .map((box) => (box as ChildBox).box))
            .fold([], (sum, list) => [...sum, ...list])
      ];
      next = children[index];
      _list.add(Prop.onlyBox(next));
      next.enableGuideline();
      _editorController.add(_list.last.field);
    }
  }

  void _forward(List<int> indices) {
    final forwardJump = indices.sublist(1);
    final parent = _list.first;
    (_list.last.box as WidgetBox).disableGuideline();
    _list.clear();
    _list.add(parent);
    WidgetBox next = parent.box;
    for (int index in forwardJump) {
      final children = <WidgetBox>[
        ...next.props
            .where((prop) => prop.box is ChildBox)
            .map((prop) => (prop.box as ChildBox).box),
        ...next.props
            .where((prop) => prop.box is ChildrenBox)
            .map((prop) => (prop.box as ChildrenBox)
                .boxes
                .map((box) => (box as ChildBox).box))
            .fold([], (sum, list) => [...sum, ...list])
      ];
      next = children[index];
      _list.add(Prop.onlyBox(next));
    }
    next.enableGuideline();
    _editorController.add(_list.last.field);
  }

  void _backward(int back, int side) {
    for (int i = 0; i < back; i++) {
      if (_list.length != 1) {
        final last = _list.removeLast().box;
        if (last is WidgetBox) {
          last.disableGuideline();
        }
      }
    }
    _sideward(side);
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
