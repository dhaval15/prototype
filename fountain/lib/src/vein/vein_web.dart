import 'dart:async';
import 'package:fountain/fountain.dart';

class Vein {
  final List<SubVein> _subVeins = [];
  Vein();
  static Vein instance;

  Future<SubVein> createSubVein() async {
    final subVein = SubVein();
    _subVeins.add(subVein);
    return subVein;
  }

  void remove(SubVein vein) {
    vein?.kill();
    _subVeins.remove(vein);
  }

  static Future init() async {
    instance = Vein();
  }

  void kill() {
    for (final vein in _subVeins) {
      vein?.kill();
    }
  }
}

class SubVein extends Sprinkle {
  void kill() => cancel();

  void run(Handler handler) async {
    add(await handler.compute());
  }

  void reset() {}
}
