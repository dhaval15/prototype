import 'package:flutter/material.dart';

import 'statusline.dart';
import 'workspace.dart';

class WorkspaceView extends StatefulWidget {
  final List<Workspace> workspaces = [
    Workspace.create('Default'),
  ];

  final int currentWorkspace = 0;
  @override
  _WorkspaceViewState createState() => _WorkspaceViewState();
}

class _WorkspaceViewState extends State<WorkspaceView> {
  int _currentWorkspace;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _currentWorkspace = widget.currentWorkspace;
    _controller =
        PageController(initialPage: _currentWorkspace, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              children: widget.workspaces,
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          ),
          Statusline(
            names:
                widget.workspaces.map((workspace) => workspace.label).toList(),
            current: widget.workspaces[_currentWorkspace].label,
            onAdd: (name) {
              widget.workspaces.add(Workspace.create(name));
              _controller.jumpToPage(widget.workspaces.length - 1);
            },
            onClose: (name) async {
              if (widget.workspaces.length > 1) {
                widget.workspaces
                    .removeWhere((workspace) => workspace.label == name);
                return true;
              } else
                return false;
            },
            onWorkspaceChanged: (name) {
              _controller.jumpToPage(widget.workspaces
                  .indexWhere((workspace) => workspace.label == name));
            },
          ),
        ],
      ),
    );
  }
}
