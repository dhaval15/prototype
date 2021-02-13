import 'dart:async';

import 'package:flutter/material.dart';
import 'package:feather/src/framework/framework.dart';

class BoxRenderView extends StatefulWidget {
  final CompositeBox<Widget> box;
  final Widget Function(BuildContext context, Stream<Widget> viewStream,
      Stream<Widget> editorStream, Stream<int> treeStream) builder;

  const BoxRenderView({Key key, this.box, this.builder}) : super(key: key);
  @override
  _BoxRenderViewState createState() => _BoxRenderViewState();
}

class _BoxRenderViewState extends State<BoxRenderView> {
  final _controller = StreamController<Widget>();
  @override
  void initState() {
    super.initState();
    widget.box.execute();
    EditContext.of(context).current = Prop.onlyBox(widget.box);
    widget.box.sprinkle.listen((_) => _controller.add(widget.box.value));
  }

  @override
  Widget build(BuildContext context) => widget.builder(
      context,
      _controller.stream,
      EditContext.of(context).editorStream,
      EditContext.of(context).treeStream);
}
