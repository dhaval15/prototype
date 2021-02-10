part of 'fields.dart';

class OptionField extends StatelessWidget {
  final ValueChangeListener<String> listener;
  final ValueNotifier<String> controller;
  final List<String> options;

  const OptionField({Key key, this.listener, this.controller, this.options})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dropdown<String>(
      controller: controller,
      items: options,
      itemBuilder: (value) => Text(value),
      selectedItembuilder: (value) => Text(value),
      onChanged: listener,
    );
  }
}
