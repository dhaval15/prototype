import 'package:box/src/box/box.dart';
import 'package:box/src/mixins/mixins.dart';

mixin CoreCodeProvider implements CodeProvider {
  @override
  String buildCode(dynamic boxMixin) => boxMixin.value.toString();
}

mixin CompositeCodeProvider implements CodeProvider {
  @override
  String buildCode(dynamic boxMixin) {
    final box = boxMixin;
    return box.boxType +
        '(' +
        box.props
            .where(_isPresent)
            .where(_isChildNotNull)
            .map((prop) =>
                (prop.index == null ? _parameter(prop.name) : '') +
                prop.box.code +
                ',')
            .join('') +
        ')';
  }
}

mixin ChildCodeProvider implements CodeProvider {
  @override
  String buildCode(boxMixin) {
    final box = boxMixin;
    return box.box.code;
  }
}
mixin MultiCodeProvider implements CodeProvider {
  @override
  String buildCode(boxMixin) {
    final box = boxMixin;
    return '[' + box.boxes.map((b) => b.code).join(',') + ',]';
  }
}

mixin StringCodeProvider implements CodeProvider {
  @override
  String buildCode(boxMixin) => '\'${boxMixin.value}\'';
}

bool _isPresent(PropMixin prop) => prop.type != null;
bool _isChildNotNull(PropMixin prop) =>
    prop.box is ChildBox ? (prop.box as ChildBox).box != null : true;
String _camelCase(String label) => label[0].toLowerCase() + label.substring(1);
String _parameter(String label) => _camelCase(label) + ':';
