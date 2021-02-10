import 'package:feather/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:feather/src/framework/framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Framework.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: EditorScreen(),
    );
  }
}
