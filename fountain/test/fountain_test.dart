import '../lib/src/sprinkle/sprinkle.dart';

void main() {
  Sprinkle sprinkle = Sprinkle();
  sprinkle.add(1);
  sprinkle.broadcast().listen(print);
  sprinkle.broadcast().listen((t) => print(t.runtimeType));
}
