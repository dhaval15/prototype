import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;
  final ValueNotifier<int> controller;
  final void Function(int) onChanged;
  final double backgroundOpacity;

  SliderWidget({
    this.onChanged,
    this.sliderHeight = 42,
    this.max = 10,
    this.min = 0,
    this.fullWidth = false,
    this.controller,
    this.backgroundOpacity = 0.2,
  });

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value;

  @override
  void initState() {
    super.initState();
    _value = (widget.controller?.value?.toDouble() ?? 0.0) / widget.max;
  }

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .1;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth
          ? double.infinity
          : (this.widget.sliderHeight) * 5.5,
      height: (this.widget.sliderHeight),
      decoration: new BoxDecoration(
        color: context.foreground.withOpacity(widget.backgroundOpacity),
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * .3)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor,
            2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              '${this.widget.min}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: context.foreground.withOpacity(0.7),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: context.foreground.withOpacity(0.7),
                    inactiveTrackColor: context.disabled.withOpacity(0.7),
                    trackHeight: 2.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbBackground: context.foreground,
                      thumbRadius: this.widget.sliderHeight * .3,
                      min: this.widget.min,
                      max: this.widget.max,
                    ),
                    thumbColor: context.canvas,
                    overlayShape: OverlayThumbRect(
                      thumbBackground: context.foreground.withOpacity(0.4),
                      thumbRadius: this.widget.sliderHeight * .4,
                    ),
                    overlayColor: context.foreground.withOpacity(.1),
                    activeTickMarkColor: context.foreground.withOpacity(.1),
                    inactiveTickMarkColor: context.disabled.withOpacity(.7),
                  ),
                  child: Slider(
                      value: _value,
                      onChanged: (value) {
                        widget.controller?.value = getValue(value);
                        widget.onChanged?.call(getValue(value));
                        setState(() {
                          _value = value;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Text(
              '${this.widget.max}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: context.foreground.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getValue(double value) {
    return (widget.min + (widget.max - widget.min) * value).round();
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;
  final Color thumbBackground;

  const CustomSliderThumbCircle({
    this.thumbBackground,
    @required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = thumbBackground
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor, //Text Color of Value on Thumb
      ),
      text: getValue(value),
    );

    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}

class OverlayThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final Color thumbBackground;

  const OverlayThumbRect({
    this.thumbBackground,
    @required this.thumbRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = thumbBackground
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius * .9, paint);
  }
}
