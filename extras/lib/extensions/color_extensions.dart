import 'package:flutter/material.dart';

extension ColorHelper on Color {
  Color lighter(int percents) {
    assert(percents >= 1 && percents <= 100);
    final int rgbPercent = (percents / 100 * 255).round();
    int red = this.red + rgbPercent,
        green = this.green + rgbPercent,
        blue = this.blue + rgbPercent;
    if (red > 255) {
      red = 255;
    }
    if (green > 255) {
      green = 255;
    }
    if (blue > 255) {
      blue = 255;
    }
    return Color.fromARGB(alpha, red, green, blue);
  }

  Color darker(int percents) {
    assert(percents >= 1 && percents <= 100);
    final int rgbPercent = (percents / 100 * 255).round();
    int red = this.red - rgbPercent,
        green = this.green - rgbPercent,
        blue = this.blue - rgbPercent;
    if (red < 0) {
      red = 0;
    }
    if (green < 0) {
      green = 0;
    }
    if (blue < 0) {
      blue = 0;
    }
    return Color.fromARGB(alpha, red, green, blue);
  }

  String toReadableString() {
    final color = toString();
    final buffer = StringBuffer();
    buffer.write('#');
    final c = color.split('(0x')[1].split(')')[0];
    buffer.write(c.substring(2));
    buffer.write(c.substring(0, 2));
    return buffer.toString();
  }
}

extension StringHelper on String {
  Color get color {
    final buffer = StringBuffer();
    buffer.write('0x');
    buffer.write(this.substring(7));
    buffer.write(this.substring(1, 7));
    return Color(int.parse(buffer.toString()));
  }
}
