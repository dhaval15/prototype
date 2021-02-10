import 'package:flutter/material.dart';
import 'option_builder.dart';

const options = [
  FontWeight.values,
  TextAlign.values,
  MainAxisAlignment.values,
  CrossAxisAlignment.values,
  MainAxisSize.values,
  VerticalDirection.values,
  FontStyle.values,
];

void main() {
  generateOptionBoxes(options);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
