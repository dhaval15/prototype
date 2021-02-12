import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  //Layout
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  Orientation get orientation => MediaQuery.of(this).orientation;
  double get aspectRatio => MediaQuery.of(this).devicePixelRatio;
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  //Them
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  //Colors
  Color get primary => Theme.of(this).primaryColor;
  Color get primaryDark => Theme.of(this).primaryColorDark;
  Color get accent => Theme.of(this).accentColor;
  Color get canvas => Theme.of(this).canvasColor;
  Color get background => Theme.of(this).backgroundColor;
  Color get error => Theme.of(this).errorColor;
  Color get disabled => Theme.of(this).disabledColor;
  Color get card => Theme.of(this).cardColor;
  Color get foreground => Theme.of(this).textTheme.subtitle1.color;
  Color get focus => Theme.of(this).focusColor;
  Color get cursor => Theme.of(this).cursorColor;
  Color get hint => Theme.of(this).hintColor;
  Color get hover => Theme.of(this).hoverColor;
  Color get splash => Theme.of(this).splashColor;
  Color get highlight => Theme.of(this).highlightColor;
  Color get textSelection => Theme.of(this).textSelectionColor;
  Color get scaffoldBackground => Theme.of(this).scaffoldBackgroundColor;

  // Text Styles
  TextStyle get headline1 => Theme.of(this).textTheme.headline1;
  TextStyle get headline2 => Theme.of(this).textTheme.headline2;
  TextStyle get headline3 => Theme.of(this).textTheme.headline3;
  TextStyle get headline4 => Theme.of(this).textTheme.headline4;
  TextStyle get headline5 => Theme.of(this).textTheme.headline5;
  TextStyle get headline6 => Theme.of(this).textTheme.headline6;
  TextStyle get bodyText1 => Theme.of(this).textTheme.bodyText1;
  TextStyle get bodyText2 => Theme.of(this).textTheme.bodyText2;
  TextStyle get subtitle1 => Theme.of(this).textTheme.subtitle1;
  TextStyle get subtitle2 => Theme.of(this).textTheme.subtitle2;
  TextStyle get caption => Theme.of(this).textTheme.caption;
  TextStyle get overline => Theme.of(this).textTheme.overline;
  TextStyle get button => Theme.of(this).textTheme.button;
}
