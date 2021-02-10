import 'package:flutter/material.dart';

class SelectionDialog extends StatelessWidget {
  final List<String> entries;

  const SelectionDialog({Key key, this.entries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(entries[index]),
            onTap: () {
              Navigator.of(context).pop(entries[index]);
            },
          ),
        ),
      ),
    );
  }
}
