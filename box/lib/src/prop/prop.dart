import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/prop/prop_extras.dart';
import 'package:flutter/material.dart';
import 'package:select/select.dart';

class Prop<T> extends PropMixin<T>
    with ValueExposerMixin<T>, FieldExposerMixin<T>, ClipboardMixin<T> {
  final int index;
  final BoxMixin<T> box;

  final T defaultValue;

  final String name;

  final GlobalKey<FreezedContainerState> key =
      GlobalKey<FreezedContainerState>();

  @override
  PropType type;

  Prop({
    this.box,
    this.defaultValue,
    this.name,
    this.type,
    this.index,
  });

  Prop<T> copyWith({
    BoxMixin<T> box,
    T defaultValue,
    String name,
    PropType type,
    int index,
  }) =>
      Prop(
        box: box ?? this.box,
        defaultValue: defaultValue ?? this.defaultValue,
        name: name ?? this.name,
        type: type ?? this.type,
        index: index ?? this.index,
      );

  factory Prop.onlyBox(BoxMixin box, {String name}) => Prop(
        box: box,
        name: name ?? '',
        type: PropType.value,
      );
}
