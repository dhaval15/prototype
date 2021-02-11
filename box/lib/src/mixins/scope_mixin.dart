import 'package:fountain/fountain.dart';

import 'box_mixin.dart';

mixin ScopeMixin {
  Map<String, BoxMixin> get variables;

  void change(String name, value) {
    variables[name].value = value;
  }

  dynamic read(String name) {
    return variables[name].value;
  }

  bool verify(String name, BoxMixin box) {
    print(
        "Scope Variable Check : ${box.runtimeType} ${variables[name].runtimeType}");
    return box.runtimeType == variables[name].runtimeType;
  }

  Sprinkle watch(String name) {
    return variables[name].sprinkle.broadcast();
  }
}
