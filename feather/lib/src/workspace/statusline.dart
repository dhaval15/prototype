import 'package:flutter/material.dart';

class Statusline extends StatefulWidget {
  final List<String> names;
  final String current;
  final void Function(String name) onWorkspaceChanged;
  final void Function(String name) onAdd;
  final Future<bool> Function(String name) onClose;

  const Statusline({
    this.names,
    this.onWorkspaceChanged,
    this.current,
    this.onAdd,
    this.onClose,
  });

  @override
  _StatuslineState createState() => _StatuslineState();
}

class _StatuslineState extends State<Statusline> {
  String _current;

  @override
  void initState() {
    super.initState();
    _current = widget.current;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final name in widget.names)
          InkWell(
            child: Container(
              color: name == _current ? Colors.red : Colors.white.withAlpha(20),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(name),
                  ),
                  InkWell(
                    onTap: () {
                      closeWorkspace(name);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.close,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              widget.onWorkspaceChanged(name);
              setState(() {
                _current = name;
              });
            },
          ),
        InkWell(
          onTap: addWorkspace,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.add,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  void addWorkspace() async {
    final name = await showDialog(
        context: context, builder: (context) => AskNameDialog());
    if (name != null && !widget.names.contains(name)) {
      widget.onAdd(name);
      setState(() {
        widget.names.add(name);
        _current = name;
      });
    }
  }

  void closeWorkspace(String name) async {
    final result = await widget.onClose(name);
    if (result) {
      setState(() {
        final index = widget.names.indexOf(name);
        widget.names.removeAt(index);
        if (_current == name) {
          if (index - 1 < 0)
            _current = widget.names[index];
          else
            _current = widget.names[index - 1];
          widget.onWorkspaceChanged(_current);
        }
      });
    }
  }
}

class AskNameDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return SimpleDialog(
      contentPadding: EdgeInsets.all(16),
      title: Text('Add Workspace'),
      children: [
        TextField(
          controller: _controller,
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
              child: Text('Add'),
            ),
          ],
        )
      ],
    );
  }
}
