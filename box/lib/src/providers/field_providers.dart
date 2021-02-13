import 'package:box/src/context/context.dart';
import 'package:box/src/mixins/mixins.dart';
import 'package:box/src/prop/prop.dart';
import 'package:flutter/material.dart';
import 'package:lambda/lambda.dart';
import 'package:extras/extras.dart';
import 'package:select/select.dart';
import 'package:box/src/box/box.dart';

const FIELD_HEIGHT = 32.0;

mixin StringFieldProvider on BoxMixin<String>
    implements FieldProvider<String>, ValueUpdateMixin<String> {
  TextEditingController controller;

  @override
  void onValue(String value) {
    if (controller?.text != value) controller?.text = value;
  }

  @override
  Widget buildField(String value) {
    controller = StringController(value);
    return StringField(
      controller: controller,
      listener: (value) {
        this.value = value is Map ? Lambda.fromJson(value) : value;
      },
    ).restrict(height: FIELD_HEIGHT);
  }
}

mixin DoubleFieldProvider on BoxMixin<double>
    implements FieldProvider<double>, ValueUpdateMixin<double> {
  DoubleController controller;

  @override
  void onValue(double value) {
    if (value != null &&
        controller?.doubleValue?.truncate() != value.truncate())
      controller?.doubleValue = value;
  }

  @override
  Widget buildField(double value) {
    controller = DoubleController(value);
    return DoubleField(
      controller: controller,
      listener: (value) {
        this.value = value is Map ? Lambda.fromJson(value) : value;
      },
    ).restrict(height: FIELD_HEIGHT);
  }
}

mixin IntFieldProvider on BoxMixin<int>
    implements FieldProvider<int>, ValueUpdateMixin<int> {
  IntController controller;

  @override
  void onValue(int value) {
    if (controller?.intValue != value) controller?.intValue = value;
  }

  @override
  Widget buildField(int value) {
    controller = IntController(value);
    return IntField(
      controller: controller,
      listener: (value) {
        this.value = value is Map ? Lambda.fromJson(value) : value;
      },
    ).restrict(height: FIELD_HEIGHT);
  }
}

mixin BoolFieldProvider on BoxMixin<bool>
    implements FieldProvider<bool>, ValueUpdateMixin<bool> {
  @override
  Widget buildField(bool value) {
    return BoolField(
      value: value,
      listener: (value) {
        this.value = value is Map ? Lambda.fromJson(value) : value;
      },
    ).restrict(height: FIELD_HEIGHT);
  }
}

mixin ColorFieldProvider on BoxMixin<Color>
    implements FieldProvider<Color>, ValueUpdateMixin<Color> {
  @override
  Widget buildField(Color value) => ColorField(
        value: value,
        listener: (value) {
          this.value = value is Map ? Lambda.fromJson(value) : value;
        },
      ).restrict(height: FIELD_HEIGHT);
}

mixin ChildFieldProvider on BaseChildBox
    implements FieldProvider<Widget>, ValueUpdateMixin<Widget> {
  @override
  Widget buildField(Widget value) => ChildField(
        value: value,
        child: this,
        listener: (value) {
          if (value is ChildAddEvent) {
            EditContextProvider.of(value.context).current = Prop.onlyBox(box);
            EditContextProvider.of(value.context).updateTree();
          } else if (value is ChildToEvent) {
            EditContextProvider.of(value.context).current = Prop.onlyBox(box);
          } else if (value is ChildDeleteEvent) {
            EditContextProvider.of(value.context).updateTree();
          }
        },
      ).restrict(height: FIELD_HEIGHT);
}

mixin OptionFieldProvider<T> on BoxMixin<T>
    implements FieldProvider<T>, ValueUpdateMixin<T>, OptionsProvider<T> {
  @override
  Widget buildField(T value) => OptionField(
        controller: ValueNotifier(
            options.entries.firstWhere((entry) => value == entry.value).key),
        listener: (value) {
          this.value = value is Map ? Lambda.fromJson(value) : options[value];
        },
        options: options.keys.toList(),
      ).restrict(height: FIELD_HEIGHT);
}

mixin RadiusFieldProvider on BoxMixin<Radius>
    implements FieldProvider<Radius>, ValueUpdateMixin<Radius> {
  DoubleController controller;

  @override
  void onValue(Radius value) {
    if (value != null &&
        controller?.doubleValue?.truncate() != value.x.truncate())
      controller?.doubleValue = value.x;
  }

  @override
  Widget buildField(Radius value) {
    controller = DoubleController(value.x);
    return DoubleField(
      controller: controller,
      listener: (value) {
        this.value = value is Map ? Lambda.fromJson(value) : value;
      },
    ).restrict(height: FIELD_HEIGHT);
  }
}

mixin CompositeFieldProvider<T> on BaseCompositeBox<T>
    implements FieldProvider<T> {
  @override
  Widget buildField(T value) =>
      buildLayout(props.map((prop) => prop.editor).toList());
}

mixin MultiFieldProvider<T> on BaseMultiBox<T>
    implements FieldProvider<List<T>> {
  @override
  Widget buildField(value) {
    final children = <Widget>[];
    for (int i = 0; i < boxes.length; i++) {
      children.add(Prop(
        box: boxes[i],
        name: 'Entry $i',
        type: PropType.value,
      ).editor);
    }
    return buildLayout(children);
  }
}
