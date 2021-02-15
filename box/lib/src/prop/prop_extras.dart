import 'package:box/src/box/box.dart';
import 'package:box/src/context/context.dart';
import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/prop/prop.dart';
import 'package:box/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lambda/lambda.dart';
import 'package:select/select.dart';

const _SCOPE_CHECK = false;

enum ActionEntry { Delete, Lambda, Scoped, Copy, Paste }

mixin FieldExposerMixin<T> on PropMixin<T> {
  Widget get field => box.buildField(value);
  Widget get label => Text(name);
  List<Widget> get actions => [
        MenuAction(
          entries: ActionEntry.values,
          onSelected: _onMenuEntrySelected,
        ),
      ];

  Widget get editor => FreezedContainer(
        key: key,
        freezed: type == null,
        field: box.buildEditor(this as Prop),
      );

  void disable() {
    // if (false) throw 'Can not change field type';
    type = null;
    key.currentState.freeze();
    box.redraw();
  }

  void enable() {
    // if (type == PropType.permanant) throw 'Can not change field type';
    type = PropType.value;
    key.currentState.unfreeze();
    box.redraw();
  }

  void _onMenuEntrySelected(BuildContext context, ActionEntry entry) {
    switch (entry) {
      case ActionEntry.Delete:
        {
          box.parent?.remove(box);
          disable();
          break;
        }
      case ActionEntry.Lambda:
        break;
      case ActionEntry.Scoped:
        (this as ValueExposerMixin).openSelectScopedVariableDialog(context);
        break;
      case ActionEntry.Copy:
        (this as ClipboardMixin).copy();
        break;
      case ActionEntry.Paste:
        (this as ClipboardMixin).paste(context);
        break;
    }
  }
}

mixin ValueExposerMixin<T> on PropMixin<T> {
  T get value {
    if (type == null || box.value == null) return _convertedDefaultValue;
    return box.value;
  }

  get code {
    if (type == null || type is ValuePropType) return box.code;
    if (type is LambdaPropType)
      return {
        '_type': 'Lambda',
        'value': (type as LambdaPropType).lambda,
      }.toString();
    if (type is ScopedPropType)
      return {
        '_type': 'Scoped',
        'value': (type as ScopedPropType).variableName,
      }.toString();
    throw 'No Code Found';
  }

  T get _convertedDefaultValue => box is ConverterMixin
      ? (box as ConverterMixin).convert(defaultValue)
      : defaultValue;

  set value(value) {
    box.value = value;
  }

  openSelectScopedVariableDialog(BuildContext context) async {
    ScopeBox scope =
        EditContextProvider.of(context).findAncestorBoxOfType<ScopeBox>();
    final names = scope.variables.keys.toList();
    final name = await showDialog(
      context: context,
      builder: (context) => SelectionDialog(entries: names),
    );
    onScopeVariableSelected(context, name);
  }

  onScopeVariableSelected(BuildContext context, String variableName) {
    if (name != null) {
      ScopeBox scope =
          EditContextProvider.of(context).findAncestorBoxOfType<ScopeBox>();
      if (!_SCOPE_CHECK || scope.verify(variableName, box)) {
        final sprinkle = scope.watch(variableName);
        type = PropType.scoped(variableName);
        key.currentState.hibernate();
        sprinkle.listen((v) => box.value = v);
      } else {
        throw 'Scoped Variable is incomiptable';
      }
    }
  }

  onScopeVariableRemoved(String variableName) {}
  onLambdaSelected(Lambda lambda) {
    box.value = lambda;
    type = PropType.lambda(lambda);
  }

  onLambdaRemoved(Lambda lambda) {
    box.value = defaultValue;
    type = PropType.value;
  }
}

mixin ClipboardMixin<T> on ValueExposerMixin<T> {
  static dynamic data;
  void copy() {
    data = code;
  }

  void paste(BuildContext context) {
    if (data != null) {
      if (data is Map) {
        if (data['_type'] == 'Scoped')
          onScopeVariableSelected(context, data['value']);
        else if (data['_type'] == 'Lambda')
          onLambdaSelected(data['lambda']);
        else
          print('Data is incomiptable');
      } else {
        box.value = data;
        type = PropType.value;
      }
    } else {
      print('No data has been copied');
    }
  }
}
