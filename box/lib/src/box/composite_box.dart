import 'package:box/box.dart';
import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/providers/providers.dart';
import 'package:lambda/lambda.dart';

var i = 0;

abstract class BaseCompositeBox<T> extends Lambda
    with
        BoxMixin<T>,
        BoxTypeMixin,
        ComplexEditorProvider,
        LayoutProvider,
        PropsProvider {
  final sprinkle = Sprinkle();
  final MultiBox parent;

  BaseCompositeBox({this.parent}) : super(null, null);

  BaseCompositeBox.dynamic(dynamic value, {this.parent})
      : super(
          value is Lambda ? value.type : CONST,
          value is Lambda ? value.params : [value],
        );

  T get value;

  set value(dynamic value) {
    update(value);
  }

  @override
  Future execute() async {
    await super.execute();
    super.sprinkle.listen(notify);
  }

  void notify(dynamic value) {
    sprinkle.add(this.value);
  }

  List get params {
    final list = [];
    props.forEach((prop) {
      list.add(prop.box);
    });
    return list;
  }

  @override
  String type = LIST;
}
