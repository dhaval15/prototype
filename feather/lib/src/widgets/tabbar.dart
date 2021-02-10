import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

class TabBar extends StatefulWidget {
  final List<String> tabs;
  final void Function(String) onChanged;
  final String selected;

  const TabBar({
    Key key,
    @required this.tabs,
    this.selected,
    this.onChanged,
  }) : super(key: key);

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> {
  String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected ?? widget.tabs[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.tabs
            .map((tab) => GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(2),
                    width: 120,
                    color: tab == selected
                        ? context.foreground.withOpacity(0.7)
                        : context.canvas,
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: tab == selected
                            ? context.canvas
                            : context.foreground.withOpacity(0.7),
                      ),
                    ).center(),
                  ),
                  onTap: () {
                    setState(() {
                      selected = tab;
                    });
                    widget.onChanged?.call(selected);
                  },
                ))
            .toList(),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: context.foreground.withOpacity(0.7))),
    ).center();
  }
}
