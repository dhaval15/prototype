import 'package:box/src/box/box.dart';
import 'package:box/src/mixins/mixins.dart';
import 'package:flutter/material.dart';

class JsonEngine {
  BoxMixin decode(Map<String, dynamic> json) {
    return null;
  }

  Map<String, dynamic> encode(BoxMixin box) {
    return _convert(box);
  }

  dynamic _convert(BoxMixin box) {
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
    if (box is BaseMultiBox)
      return '[' + box.boxes.map((b) => _convert(b)).join(',') + ',]';
    if (box.value is Color) return box.value.value;
    if (box.value is String) return '"${box.value}"';
    if (box.value != null) return box.value;
    return null;
  }

  String _parameter(String label) => _camelCase(label);
}

bool _isPresent(PropMixin prop) => prop.type != null;
bool _isChildNotNull(PropMixin prop) =>
    prop.box is ChildBox ? (prop.box as ChildBox).box != null : true;
String _camelCase(String label) => label[0].toLowerCase() + label.substring(1);
