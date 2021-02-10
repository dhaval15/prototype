import 'dart:async';
import 'package:fountain/fountain.dart';

class Vein {
  static Vein get instance => throw UnsupportedError('instance');

  Future<SubVein> createSubVein() => throw UnsupportedError('createSubVein');
  void remove(SubVein vein) => throw UnsupportedError('remove');

  static Future init() => throw UnsupportedError('init');

  void kill() => throw UnsupportedError('kill');
}

class SubVein extends Sprinkle {
  void kill() => throw UnsupportedError('kill');

  void run(Handler handler) => throw UnsupportedError('run');

  void reset() => throw UnsupportedError('reset');
}
