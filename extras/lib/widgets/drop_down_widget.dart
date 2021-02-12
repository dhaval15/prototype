import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

class Dropdown<T> extends StatefulWidget {
  final ValueNotifier<T> controller;
  final List<T> items;
  final void Function(T value) onChanged;
  final Widget Function(T item) itemBuilder;
  final Widget Function(T item) selectedItembuilder;

  const Dropdown({
    Key key,
    this.controller,
    this.items,
    this.onChanged,
    this.itemBuilder,
    this.selectedItembuilder,
  }) : super(key: key);

  @override
  _DropdownState<T> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown<T>> {
  T _value;
  @override
  void initState() {
    super.initState();
    _value = widget.controller?.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isDense: true,
      underline: SizedBox(),
      icon: SizedBox(),
      isExpanded: true,
      value: _value,
      selectedItemBuilder: (context) =>
          widget.items.map(widget.selectedItembuilder).toList(),
      items: widget.items
          .map((item) => DropdownMenuItem<T>(
                child: widget.itemBuilder(item),
                value: item,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _value = value;
          widget.controller?.value = value;
          widget.onChanged?.call(value);
        });
      },
    ).padding(vertical: 8, horizontal: 2);
  }
}
