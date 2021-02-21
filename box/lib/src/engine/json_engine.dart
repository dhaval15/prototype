import 'package:box/box.dart';
import 'package:box/src/box/box.dart';
import 'package:box/src/mixins/mixins.dart';

class JsonEngine {
  static BoxGeneratorMixin generator;
  static BoxMixin decode(Map<String, dynamic> json) {
    final type = json['_type'];
    final box = generator.any(type)(json);
    return box;
  }

  static Map<String, dynamic> encode(BoxMixin box) {
    return _convert(box);
  }

  static dynamic _convert(BoxMixin box) {
    if (box is CompositeBox) {
      final json = <String, dynamic>{
        '_type': box.boxType,
      };
      box.props.where(_isPresent).where(_isChildNotNull).forEach((prop) {
        final value = _convert(prop.box);
        if (value != null)
          json[prop.index == null ? _parameter(prop.name) : '#${prop.index}'] =
              value;
      });
      return json;
    }
    if (box is ChildBox) return _convert(box.box);
    if (box is AbstractBox) return _convert(box.box);
    if (box is BaseMultiBox) return box.boxes.map((b) => _convert(b)).toList();
    if (box is RadiusBox) return box.value.x;
    if (box.value == null) return null;
    if (box is JsonMixin) return (box as JsonMixin).json;
    throw 'Unsupported Type ${box.runtimeType}';
  }
}

String _parameter(String label) => _camelCase(label);
bool _isPresent(PropMixin prop) => prop.type != null;
bool _isChildNotNull(PropMixin prop) =>
    prop.box is ChildBox ? (prop.box as ChildBox).box != null : true;
String _camelCase(String label) => label[0].toLowerCase() + label.substring(1);
