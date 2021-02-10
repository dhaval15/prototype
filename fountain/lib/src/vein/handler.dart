import 'dart:async';

typedef HandlerBuilder = Handler Function();

const CONST = '_const';
const NULL = '_null';
const CONCATATION = '_concat';
const LIST = '_list';
const ADDITION = '_add';
const SUBSTRACTION = '_sub';
const MULTIPLICATION = '_multi';
const DIVISION = '_div';
const MODULO = '_modulo';
const IF = '_if';

class Null {
  Null._();
}

abstract class Handler {
  static final Map<String, HandlerBuilder> _handlers = Map();
  static final Map<String, HandlerBuilder> _nativeHandlers = {
    NULL: () => NullHandler(),
    IF: () => IfHandler(),
    CONST: () => ConstHandler(),
    CONCATATION: () => ConcatHandler(),
    LIST: () => ListHandler(),
    ADDITION: () => AdditionHandler(),
    SUBSTRACTION: () => SubstractionHandler(),
    MULTIPLICATION: () => MultiplicationHandler(),
    DIVISION: () => DivisionHandler(),
    MODULO: () => ModuloHandler(),
  };

  static List<String> get types => _handlers.keys.toList();

  static void register(String type, HandlerBuilder handler) {
    _handlers[type] = handler;
  }

  static void registerMany(Map<String, HandlerBuilder> map) {
    _handlers.addAll(map);
  }

  static Handler builder(String type) {
    if (type.startsWith('_')) {
      final handlerBuilder = _nativeHandlers[type];
      if (handlerBuilder != null) return handlerBuilder();
      throw 'NativeHandler not found of type \'$type\', Don\'t start type with \'_\' ';
    }
    final handlerBuilder = _handlers[type];
    if (handlerBuilder != null) return handlerBuilder();
    throw 'Handler not found of type \'$type\' ';
  }

  Duration get repeatingDuration;
  Future compute();

  List params;
}

class ConstHandler extends Handler {
  ConstHandler();

  @override
  Future compute() async {
    return params[0];
  }

  @override
  String toString() => params[0];

  @override
  Duration get repeatingDuration => null;
}

class NullHandler extends Handler {
  NullHandler();

  @override
  Future compute() async {
    return Null._();
  }

  @override
  String toString() => params[0];

  @override
  Duration get repeatingDuration => null;
}

class ConcatHandler extends Handler {
  ConcatHandler();

  @override
  Future compute() async {
    return params.join();
  }

  @override
  Duration get repeatingDuration => null;
}

class ListHandler extends Handler {
  ListHandler();

  @override
  Future compute() async {
    return params;
  }

  @override
  Duration get repeatingDuration => null;
}

class AdditionHandler extends Handler {
  AdditionHandler();

  @override
  Future compute() async {
    return params[0] + params[1];
  }

  @override
  Duration get repeatingDuration => null;
}

class SubstractionHandler extends Handler {
  SubstractionHandler();

  @override
  Future compute() async {
    return params[0] - params[1];
  }

  @override
  Duration get repeatingDuration => null;
}

class MultiplicationHandler extends Handler {
  MultiplicationHandler();

  @override
  Future compute() async {
    return params[0] * params[1];
  }

  @override
  Duration get repeatingDuration => null;
}

class DivisionHandler extends Handler {
  DivisionHandler();

  @override
  Future compute() async {
    return params[0] / params[1];
  }

  @override
  Duration get repeatingDuration => null;
}

class ModuloHandler extends Handler {
  ModuloHandler();

  @override
  Future compute() async {
    return params[0] % params[1];
  }

  @override
  Duration get repeatingDuration => null;
}

class IfHandler extends Handler {
  @override
  Future compute() async {
    if (params[0])
      return params[1];
    else
      return params[2];
  }

  @override
  Duration get repeatingDuration => null;
}
