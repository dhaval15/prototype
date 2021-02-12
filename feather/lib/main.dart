import 'package:flutter/material.dart';
import 'src/framework/framework.dart';
import 'src/workspace/workspace_view.dart';

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
      home: WorkspaceView(),
    );
  }
}
