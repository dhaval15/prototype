import 'package:box/src/box/box.dart';
import 'package:box/src/mixins/mixins.dart';

class CodeEngine {
  static String encode(BoxMixin box, {String className = 'Output'}) {
    return '''
import 'package:flutter/material.dart';

class $className extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	  return ${_convert(box)};
  }
}
			''';
  }

  static String _convert(BoxMixin box) {
    if (box is CompositeBox)
      return box.boxType +
          '(' +
          box.props
              .where(_isPresent)
              .where(_isChildNotNull)
              .map((prop) {
                final value = _convert(prop.box);
                if (value != null)
                  return (prop.index == null ? _parameter(prop.name) : '') +
                      value +
                      ',';
                return null;
              })
              .where((value) => value != null)
              .join('') +
          ')';
    if (box is ChildBox) return _convert(box.box);
    if (box is AbstractBox) return _convert(box.box);
    if (box is BaseMultiBox)
      return '[' + box.boxes.map((b) => _convert(b)).join(',') + ',]';
    if (box.value is String) return '\'${box.value}\'';
    if (box.value != null) return box.value.toString();
    return null;
  }
}

String _parameter(String label) => _camelCase(label) + ':';
bool _isPresent(PropMixin prop) => prop.type != null;
bool _isChildNotNull(PropMixin prop) =>
    prop.box is ChildBox ? (prop.box as ChildBox).box != null : true;
String _camelCase(String label) => label[0].toLowerCase() + label.substring(1);
