import 'package:box/box.dart';
import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/providers/providers.dart';
import 'package:lambda/lambda.dart';

class CoreBox<T> extends Lambda
    with
        BoxMixin<T>,
        ConverterMixin<T>,
        SimpleEditorProvider,
        JsonMixin,
        CoreCodeProvider {
  final sprinkle = Sprinkle();

  final MultiBox parent;

  CoreBox(String type, List params, {this.parent}) : super(type, params);

  CoreBox.value(value, {this.parent}) : super(CONST, [value]) {
    boxedValue = convert(value);
  }
  CoreBox.lambda(Lambda lambda, {this.parent})
      : super(lambda.type, lambda.params);

  CoreBox.dynamic({dynamic data, this.parent})
      : super(data is Lambda ? data.type : CONST,
            data is Lambda ? data.params : [data]) {
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

  @override
  get json => value;
}
