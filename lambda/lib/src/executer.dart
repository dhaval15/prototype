part of 'package:lambda/src/lambda.dart';

class LambdaExecutor {
  SubVein vein;
  Sprinkle paramsSprinkle;

  Future init() async {
    vein = await Vein.instance.createSubVein();
  }

  Future execute(Lambda lambda) async {
    if (lambda.type == CONST) {
      vein?.run(ConstHandler()..params = lambda.params);
    } else if (lambda.type == NULL) {
      vein.run(NullHandler()..params = lambda.params);
    } else {
      paramsSprinkle?.cancel();
      paramsSprinkle = await lambda.params.toFlow();
      paramsSprinkle.listen((parameters) {
        vein.run(Handler.builder(lambda.type)..params = parameters);
      });
    }
  }

  void kill() {
    paramsSprinkle?.cancel();
    vein.kill();
    Vein.instance.remove(vein);
    vein = null;
  }

  void reset() {
    paramsSprinkle?.cancel();
    vein?.reset();
  }
}

extension on List<dynamic> {
  Future<CombinerSprinkle> toFlow() async {
    for (Lambda lambda in this) {
      await lambda.execute();
    }
    return Sprinkle.combine(cast<Lambda>().map((e) => e.sprinkle).toList());
  }

  void kill() {
    for (final lambda in this) {
      if (lambda is Lambda) {
        lambda.kill();
      }
    }
  }
}
