import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget padding(
          {double all,
          double horizontal,
          double vertical,
          double left,
          double right,
          double top,
          double bottom}) =>
      Padding(
        padding: EdgeInsets.only(
          left: left ?? horizontal ?? all ?? 0,
          right: right ?? horizontal ?? all ?? 0,
          top: top ?? vertical ?? all ?? 0,
          bottom: bottom ?? vertical ?? all ?? 0,
        ),
        child: this,
      );

  Widget margin(
          {double all,
          double horizontal,
          double vertical,
          double left,
          double right,
          double top,
          double bottom}) =>
      Container(
        margin: EdgeInsets.only(
          left: left ?? horizontal ?? all ?? 0,
          right: right ?? horizontal ?? all ?? 0,
          top: top ?? vertical ?? all ?? 0,
          bottom: left ?? bottom ?? all ?? 0,
        ),
        child: this,
      );

  Widget color({
    Color color,
    double radius,
    Color border,
    double borderWidth = 0,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius != null ? BorderRadius.circular(radius) : null,
          border: border != null
              ? Border.all(
                  color: border,
                  width: borderWidth,
                )
              : null,
        ),
        child: this,
      );

  Widget restrict({
    double width,
    double height,
  }) =>
      SizedBox(
        width: width,
        height: height,
        child: this,
      );

  Widget decorate(BoxDecoration decoration) => Container(
        child: this,
        decoration: decoration,
      );

  Widget clip(
    CustomClipper<Rect> clipper, {
    Clip clipBehaviour = Clip.hardEdge,
  }) =>
      ClipRect(
        clipper: clipper,
        clipBehavior: clipBehaviour,
        child: this,
      );

  Widget clipRound(
    BorderRadius borderRadius, {
    Clip clipBehaviour = Clip.antiAlias,
  }) =>
      ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: clipBehaviour,
        child: this,
      );

  Widget topLeft() => Align(
        child: this,
        alignment: Alignment.topLeft,
      );

  Widget topCenter() => Align(
        child: this,
        alignment: Alignment.topCenter,
      );

  Widget topRight() => Align(
        child: this,
        alignment: Alignment.topRight,
      );

  Widget centerLeft() => Align(
        child: this,
        alignment: Alignment.centerLeft,
      );

  Widget center() => Center(
        child: this,
      );

  Widget centerRight() => Align(
        child: this,
        alignment: Alignment.centerRight,
      );

  Widget bottomLeft() => Align(
        child: this,
        alignment: Alignment.bottomLeft,
      );

  Widget bottomCenter() => Align(
        child: this,
        alignment: Alignment.bottomCenter,
      );

  Widget bottomRight() => Align(
        child: this,
        alignment: Alignment.bottomRight,
      );

  Widget align(Alignment alignment) => Align(
        alignment: alignment,
        child: this,
      );

  Widget expand([int flex = 1]) => Expanded(
        flex: flex,
        child: this,
      );

  Widget flex([int flex = 1]) => Flexible(
        flex: flex,
        child: this,
      );

  Widget onTap(void Function() callback) => GestureDetector(
        onTap: callback,
        child: this,
      );

  Widget pushOnClick() => TranslateOnClick(child: this);
}

extension TextExtensions on Text {
  Widget tile() => ListTile(title: this);
}

class ListItemView<T> extends StatelessWidget {
  final Axis scrollDirection;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final List<T> items;
  final Widget separator;
  const ListItemView({
    this.itemBuilder,
    this.separatorBuilder,
    this.scrollDirection = Axis.vertical,
    this.items,
    this.separator = const SizedBox(),
  });
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      separatorBuilder: separatorBuilder != null
          ? separatorBuilder
          : (context, _) => separator,
      itemCount: items.length,
      itemBuilder: (context, index) =>
          itemBuilder(context, items[index], index),
    );
  }
}

class TranslateOnClick extends StatefulWidget {
  final Widget child;

  const TranslateOnClick({Key key, this.child}) : super(key: key);

  @override
  _TranslateOnClickState createState() => _TranslateOnClickState();
}

class _TranslateOnClickState extends State<TranslateOnClick> {
  final nonClickTransform = Matrix4.identity();
  final clickTransform = Matrix4.identity()..translate(0, -10, 0);

  bool _clicking = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d) => _userClick(true),
      onTapUp: (d) => _userClick(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: widget.child,
        transform: _clicking ? clickTransform : nonClickTransform,
      ),
    );
  }

  void _userClick(bool click) {
    setState(() {
      _clicking = click;
    });
  }
}
