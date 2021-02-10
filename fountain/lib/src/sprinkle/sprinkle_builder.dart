import 'package:flutter/material.dart';
import 'package:fountain/fountain.dart';

class SprinkleBuilder<T> extends StatefulWidget {
  final Widget Function(BuildContext context, T data) builder;
  final Sprinkle sprinkle;

  const SprinkleBuilder({Key key, this.builder, this.sprinkle})
      : assert(sprinkle != null),
        super(key: key);
  @override
  _SprinkleBuilderState<T> createState() => _SprinkleBuilderState<T>();
}

class _SprinkleBuilderState<T> extends State<SprinkleBuilder<T>> {
  T data;
  @override
  void initState() {
    super.initState();
    widget.sprinkle.listen((data) {
      setState(() {
        this.data = data;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.sprinkle.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, data);
  }
}
