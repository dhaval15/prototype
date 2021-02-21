import 'package:flutter/material.dart';

import 'statusline.dart';
import 'workspace.dart';

class WorkspaceView extends StatefulWidget {
  final List<Workspace> workspaces;

  final int currentWorkspace;

  WorkspaceView({
    List<Workspace> workspaces,
    this.currentWorkspace = 0,
  }) : this.workspaces = workspaces ?? [Workspace.create('Default')];

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
            workspaces: widget.workspaces,
            current: 0,
            onWorkspaceChanged: (index) {
              _controller.jumpToPage(index);
            },
          ),
        ],
      ),
    );
  }
}
