part of 'framework.dart';

Future _init() async {
  await Vein.init();
  ChildField.generator = BoxRegistery.instance;
  ScopeBox.generator = BoxRegistery.instance;
  // JsonEngine.registry = BoxRegistery.instance.any;
  BoxRegistery.instance.registerManyWidgets({
    'Container': ([Map<String, dynamic> data = const {}]) => ContainerBox(data),
    'Text': ([Map<String, dynamic> data = const {}]) => TextBox(data),
    'Center': ([Map<String, dynamic> data = const {}]) => CenterBox(data),
    'Card': ([Map<String, dynamic> data = const {}]) => CardBox(data),
    'Padding': ([Map<String, dynamic> data = const {}]) => PaddingBox(data),
    'Column': ([Map<String, dynamic> data = const {}]) => ColumnBox(data),
    'Row': ([Map<String, dynamic> data = const {}]) => RowBox(data),
    'Scope': ([Map<String, dynamic> data = const {}]) => ScopeBox(data),
    // 'Scope': ([Map<String, dynamic> data = const {}]) => ScopeBox(data),
  });
  BoxRegistery.instance.registerManyBoxes({
    'BoxShadow': ([Map<String, dynamic> data = const {}]) => BoxShadowBox(data),
    'String': ([Map<String, dynamic> data = const {}]) =>
        StringBox.dynamic(data['value'] ?? ''),
    'Color': ([Map<String, dynamic> data = const {}]) =>
        ColorBox.dynamic(data['value']),
    'Double': ([Map<String, dynamic> data = const {}]) =>
        DoubleBox.dynamic(data['value'] ?? ''),
    'Integer': ([Map<String, dynamic> data = const {}]) =>
        IntBox.dynamic(data['value'] ?? 0),
  });
}

String _generateCode(BoxMixin box, {String label = 'Output'}) =>
    CodeEngine().encode(box, className: label);

Map<String, dynamic> _generateJson(BoxMixin box) => JsonEngine().encode(box);

BoxMixin _loadBoxFromJson(Map<String, dynamic> json) =>
    JsonEngine().decode(json, BoxRegistery.instance);
