import 'dart:async';

import 'package:flutter/widgets.dart';

mixin Initializer<T extends StatefulWidget> on State<T> {
  Completer _completer = Completer();

  Future get ensureInitialized => _completer.future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    print('Initialized ${this.runtimeType}');
    _completer.complete();
  }
}

mixin InitializerMixin {
  Completer _completer = Completer();

  Future get ensureInitialized => _completer.future;

  void init() async {
    print('Initialized ${this.runtimeType}');
    _completer.complete();
  }
}
