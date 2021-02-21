import 'package:feather/src/workspace/workspace.dart';
import 'package:flutter/material.dart';

class Statusline extends StatefulWidget {
  final List<Workspace> workspaces;
  final int current;
  final void Function(int index) onWorkspaceChanged;

  const Statusline({
    this.workspaces,
    this.onWorkspaceChanged,
    this.current,
  });

  @override
  _StatuslineState createState() => _StatuslineState();
}

class _StatuslineState extends State<Statusline> {
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.current;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int index = 0; index < widget.workspaces.length; index++)
          InkWell(
            child: Container(
              color: index == _currentIndex
                  ? Colors.red
                  : Colors.white.withAlpha(20),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(widget.workspaces[index].label),
                  ),
                  InkWell(
                    onTap: () {
                      closeWorkspace(index);
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
              widget.onWorkspaceChanged(index);
              setState(() {
                _currentIndex = index;
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
        InkWell(
          onTap: loadWorkspace,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.upload_file,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  void loadWorkspace() async {
    final workspace = await Workspace.load();
    final name = workspace.label;
    if (name != null) {
      widget.workspaces.add(workspace);
      widget.onWorkspaceChanged(widget.workspaces.length - 1);
      setState(() {
        _currentIndex = widget.workspaces.length - 1;
      });
    }
  }

  void addWorkspace() async {
    final name = await showDialog(
        context: context, builder: (context) => AskNameDialog());
    if (name != null) {
      final workspace = Workspace.create(name);
      widget.workspaces.add(workspace);
      widget.onWorkspaceChanged(widget.workspaces.length - 1);
      setState(() {
        _currentIndex = widget.workspaces.length - 1;
      });
    }
  }

  void closeWorkspace(int index) async {
    final result = await onClose();
    if (result) {
      setState(() {
        widget.workspaces.removeAt(index);
        if (_currentIndex == index) {
          if (index - 1 < 0)
            _currentIndex = index;
          else
            _currentIndex = index - 1;
          widget.onWorkspaceChanged(_currentIndex);
        }
      });
    }
  }

  Future<bool> onClose() async {
    return widget.workspaces.length > 1;
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
