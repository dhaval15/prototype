import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/providers/providers.dart';
import 'package:lambda/lambda.dart';

abstract class BaseMultiBox<T> extends Lambda
    with
        BoxMixin<List<T>>,
        BoxTypeMixin,
        ComplexLayoutProvider,
        ComplexEditorProvider {
  final ListSprinkle sprinkle;
  final List<BoxMixin> boxes;
  final BoxMixin Function() onAdd;
  BaseMultiBox(List boxes, {this.onAdd})
      : this.boxes = List.from(boxes ?? []),
        this.sprinkle = ListSprinkle(
            boxes.map((box) => box.sprinkle).toList().cast<Sprinkle>()),
        super(null, null);

  List<T> get value => sprinkle.last.isEmpty ? <T>[] : sprinkle.last.cast<T>();

  set value(dynamic value) {
    // update(value);
  }

  Future append({BoxMixin lambda}) async {
    final box = lambda ?? onAdd();
    boxes.add(box);
    await box.execute();
    sprinkle.append(box.sprinkle);
  }

  void remove(lambda) async {
    lambda.kill();
    boxes.remove(lambda);
  }

  Future execute() async {
    for (final lambda in boxes) {
      await lambda.execute();
    }
  }
}
