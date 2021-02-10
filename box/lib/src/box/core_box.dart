import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/providers/providers.dart';
import 'package:lambda/lambda.dart';

class CoreBox<T> extends Lambda
    with
        BoxMixin<T>,
        ConverterMixin<T>,
        SimpleEditorProvider,
        CoreCodeProvider {
  final sprinkle = Sprinkle();

  CoreBox(String type, List params) : super(type, params);

  CoreBox.value(value) : super(CONST, [value]) {
    boxedValue = convert(value);
  }
  CoreBox.lambda(Lambda lambda) : super(lambda.type, lambda.params);

  CoreBox.dynamic(dynamic value)
      : super(value is Lambda ? value.type : CONST,
            value is Lambda ? value.params : [value]) {
    if (!(value is Lambda)) boxedValue = convert(value);
  }

  T boxedValue;

  T get value => boxedValue;

  set value(dynamic value) {
    update(value);
  }

  @override
  Future execute() async {
    await super.execute();
    super.vein.listen(notify);
  }

  void notify(dynamic value) {
    boxedValue = convert(value);
    sprinkle.add(boxedValue);
    onValue(this.value);
  }

  @override
  T convert(value) {
    return value;
  }
}
