import 'dart:async';

import 'package:flutter/material.dart';
import 'package:feather/src/framework/framework.dart';

class BoxRenderView extends StatefulWidget {
  final CompositeBox<Widget> box;
  final Widget Function(BuildContext context, Stream<Widget> viewController,
      Stream<Widget> editorController) builder;

  const BoxRenderView({Key key, this.box, this.builder}) : super(key: key);
  @override
  _BoxRenderViewState createState() => _BoxRenderViewState();
}

class _BoxRenderViewState extends State<BoxRenderView> {
  final _controller = StreamController<Widget>();
  Widget child = CircularProgressIndicator();
  Widget editor = SizedBox();
  @override
  void initState() {
    super.initState();
    widget.box.execute();
    EditContext.of(context).current = Prop.onlyBox(widget.box);
    widget.box.sprinkle.listen((_) => _controller.add(widget.box.value));
  }

  @override
  Widget build(BuildContext context) => widget.builder(
      context, _controller.stream, EditContext.of(context).editorStream);
}
