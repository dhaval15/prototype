import 'dart:collection';
import 'framework.dart';

typedef WidgetBoxCreator = WidgetBox Function([Map<String, dynamic> data]);
typedef BoxCreator = BoxMixin Function([Map<String, dynamic> data]);

class BoxRegistery with ChildGenerator, BoxGeneratorMixin {
  static final instance = BoxRegistery();

  final _widgetBoxCreators = HashMap<String, WidgetBoxCreator>();
  final _boxCreators = HashMap<String, BoxCreator>();

  @override
  WidgetBoxCreator widget(String type) => _widgetBoxCreators[type];

  BoxCreator any(String type) => _widgetBoxCreators[type] ?? _boxCreators[type];

  @override
  List<String> get widgets => _widgetBoxCreators.keys.toList();

  BoxCreator box(String type) => _boxCreators[type];

  void registerWidget(String type, WidgetBoxCreator creator) =>
      _widgetBoxCreators[type] = creator;

  void registerManyWidgets(Map<String, WidgetBoxCreator> creators) =>
      _widgetBoxCreators.addAll(creators);

  void registerBox(String type, BoxCreator creator) =>
      _boxCreators[type] = creator;

  void registerManyBoxes(Map<String, BoxCreator> creators) =>
      _boxCreators.addAll(creators);

  @override
  List<String> get types => [..._boxCreators.keys, ..._widgetBoxCreators.keys];
}
