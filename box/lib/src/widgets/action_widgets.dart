import 'package:box/src/prop/prop.dart';
import 'package:box/src/prop/prop_extras.dart';
import 'package:extras/extras.dart';
import 'package:flutter/material.dart';

import 'props_dialog.dart';
import 'widgets.dart';

const ICON_SIZE = 20.0;

class MenuAction extends StatelessWidget {
  final List<ActionEntry> entries;
  final void Function(BuildContext context, ActionEntry entry) onSelected;

  const MenuAction({
    Key key,
    this.entries,
    this.onSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ActionEntry>(
      child: Icon(
        Icons.more_vert,
        size: ICON_SIZE,
      ).padding(all: 6),
      onSelected: (entry) => onSelected(context, entry),
      itemBuilder: (BuildContext context) => entries
          .map((entry) => PopupMenuItem(
                child: Text(entry.toString().split('.')[1]),
                value: entry,
              ))
          .toList(),
    );
  }
}

class DeleteAction extends StatelessWidget {
  final Function onDelete;

  const DeleteAction(this.onDelete);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.delete,
        size: ICON_SIZE,
      ).padding(all: 6),
      onTap: onDelete,
    );
  }
}

class CopyAction extends StatelessWidget {
  final Function onCopy;

  const CopyAction(this.onCopy);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.copy,
        size: ICON_SIZE,
      ).padding(all: 6),
      onTap: onCopy,
    );
  }
}

class PasteAction extends StatelessWidget {
  final Function onPaste;

  const PasteAction(this.onPaste);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.paste,
        size: ICON_SIZE,
      ).padding(all: 6),
      onTap: onPaste,
    );
  }
}

class AddPropAction extends StatelessWidget {
  final List<Prop> props;

  const AddPropAction(this.props);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.add,
        size: ICON_SIZE,
      ).padding(all: 6),
      onTap: () async {
        final filteredProps = props.where((prop) => prop == null).toList();
        final prop = await PropsDialog.show(context, filteredProps);
        if (prop != null) {
          prop.enable();
        }
      },
    );
  }
}

class AddAction extends StatelessWidget {
  final void Function() onAdd;

  const AddAction(this.onAdd);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.add,
        size: ICON_SIZE,
      ).padding(all: 6),
      onTap: onAdd,
    );
  }
}
