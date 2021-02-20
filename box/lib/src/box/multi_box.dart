import 'package:box/box.dart';
import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/providers/providers.dart';
import 'package:lambda/lambda.dart';

abstract class BaseMultiBox<T> extends Lambda
    with
        BoxMixin<List<T>>,
        BoxTypeMixin,
        ComplexLayoutProvider,
        ComplexEditorProvider {
  final ListSprinkle sprinkle = ListSprinkle([]);
  final List<BoxMixin> boxes = [];
  final BoxMixin Function(BoxMixin parent, [dynamic value]) onAdd;
  BaseMultiBox({List data, this.onAdd}) : super(null, null) {
    if (data != null && data.isNotEmpty) {
      data.forEach((item) {
        final box = onAdd(this, item);
        boxes.add(box);
      });
    }
  }

  List<T> get value => sprinkle.last.isEmpty ? <T>[] : sprinkle.last.cast<T>();

  set value(dynamic value) {
    // update(value);
  }

  Future append({BoxMixin lambda}) async {
    final box = lambda ?? onAdd(this);
    boxes.add(box);
    await box.execute();
    sprinkle.append(box.sprinkle);
  }

  void remove(BoxMixin box) {
    (box as Lambda).kill();
    boxes.remove(box);
    sprinkle.remove(box.sprinkle);
    redraw();
  }

  Future execute() async {
    for (final box in boxes) {
      await box.execute();
    }
    for (final box in boxes) {
      sprinkle.append(box.sprinkle);
    }
  }
}
