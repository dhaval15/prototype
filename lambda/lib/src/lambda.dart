import 'dart:async';

import 'package:fountain/fountain.dart';

part 'keywords.dart';
part 'executer.dart';

class Lambda<T> {
  String type;
  List params;
  String key;
  final LambdaExecutor executor = LambdaExecutor();

  SubVein get vein => executor.vein;
  Sprinkle get sprinkle => executor.vein;

  Lambda.empty();

  Lambda(this.type, this.params);

  factory Lambda.value(dynamic value) => Lambda(CONST, [value]);
  factory Lambda.nullify() => Lambda(NULL, []);

  factory Lambda.fromJson(dynamic data) {
    if (data is Map) {
      final type = data['type'];
      List params = data['params'];
      return Lambda(
          type, params.map((param) => Lambda.fromJson(param)).toList());
    }
    return Lambda.value(data);
  }

  dynamic toJson() {
    if (type == CONST) return params[0];
    return {
      'k': key,
      't': type.toString(),
      'p': params.map((p) => p.toJson()).toList()
    };
  }

  Future execute() async {
    await executor.init();
    await executor.execute(this);
  }

  Future update(dynamic value) async {
    Lambda lambda = value is Lambda ? value : Lambda.value(value);
    reset();
    type = lambda.type;
    params = lambda.params;
    await executor.execute(this);
  }

  void reset() {
    executor.reset();
    params.kill();
  }

  void kill() {
    executor.kill();
    params.kill();
  }

  Lambda operator -() => Lambda.value(0) - this;

  Lambda operator +(dynamic other) =>
      Lambda(ADDITION, [this, other is Lambda ? other : Lambda.value(other)]);
  Lambda operator -(dynamic other) => Lambda(
      SUBSTRACTION, [this, other is Lambda ? other : Lambda.value(other)]);
  Lambda operator *(dynamic other) => Lambda(
      MULTIPLICATION, [this, other is Lambda ? other : Lambda.value(other)]);
  Lambda operator /(dynamic other) =>
      Lambda(DIVISION, [this, other is Lambda ? other : Lambda.value(other)]);
  Lambda operator %(dynamic other) =>
      Lambda(MODULO, [this, other is Lambda ? other : Lambda.value(other)]);
}
