part of 'framework.dart';

Future _init() async {
  await Vein.init();
  ChildField.generator = BoxRegistery.instance;
  ScopeBox.generator = BoxRegistery.instance;
  JsonEngine.generator = BoxRegistery.instance;
  BoxRegistery.instance.registerManyWidgets({
    'Container': ([Map<String, dynamic> data = const {}]) =>
        ContainerBox(data: data),
    'Text': ([Map<String, dynamic> data = const {}]) => TextBox(data: data),
    'Center': ([Map<String, dynamic> data = const {}]) => CenterBox(data: data),
    'Card': ([Map<String, dynamic> data = const {}]) => CardBox(data: data),
    'Padding': ([Map<String, dynamic> data = const {}]) =>
        PaddingBox(data: data),
    'Column': ([Map<String, dynamic> data = const {}]) => ColumnBox(data: data),
    'Row': ([Map<String, dynamic> data = const {}]) => RowBox(data: data),
    'Scope': ([Map<String, dynamic> data = const {}]) => ScopeBox(data),
    // 'Scope': ([Map<String, dynamic> data = const {}]) => ScopeBox(data),
  });
  BoxRegistery.instance.registerManyBoxes({
    'BoxShadow': ([Map<String, dynamic> data = const {}]) =>
        BoxShadowBox(data: data),
    'String': ([Map<String, dynamic> data = const {}]) =>
        StringBox.dynamic(data: data['value'] ?? ''),
    'Color': ([Map<String, dynamic> data = const {}]) =>
        ColorBox.dynamic(data: data['value']),
    'Double': ([Map<String, dynamic> data = const {}]) =>
        DoubleBox.dynamic(data: data['value'] ?? ''),
    'Integer': ([Map<String, dynamic> data = const {}]) =>
        IntBox.dynamic(data: data['value'] ?? 0),
  });
}

String _generateCode(BoxMixin box, {String label = 'Output'}) =>
    CodeEngine.encode(box, className: label);

Map<String, dynamic> _generateJson(BoxMixin box) => JsonEngine.encode(box);

BoxMixin _loadBoxFromJson(Map<String, dynamic> json) => JsonEngine.decode(json);
