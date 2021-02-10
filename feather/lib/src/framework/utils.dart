part of 'framework.dart';

Future _init() async {
  await Vein.init();
  ChildField.generator = BoxRegistery.instance;
  ScopeBox.generator = BoxRegistery.instance;
  // JsonEngine.registry = BoxRegistery.instance.any;
  BoxRegistery.instance.registerManyWidgets({
    'Container': ([data = const {}]) => ContainerBox(data),
    'Text': ([data = const {}]) => TextBox(data),
    'Center': ([data = const {}]) => CenterBox(data),
    'Card': ([data = const {}]) => CardBox(data),
    'Padding': ([data = const {}]) => PaddingBox(data),
    'Column': ([data = const {}]) => ColumnBox(data),
    'Row': ([data = const {}]) => RowBox(data),
    'Scope': ([data = const {}]) => ScopeBox(data),
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

String _generateCode(BoxMixin box) => CodeEngine().encode(box);
