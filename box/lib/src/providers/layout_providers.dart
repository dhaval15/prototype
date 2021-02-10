import 'package:box/src/mixins/mixins.dart';
import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

mixin ColumnLayoutProvider implements LayoutProvider {
  @override
  Widget buildLayout(List<Widget> children) => Column(
        children: children.separate(SizedBox(height: 4)),
      );
}

mixin ComplexLayoutProvider implements LayoutProvider {
  @override
  Widget buildLayout(List<Widget> children) => Column(
        children: children.separate(SizedBox(height: 4)),
      );
}

mixin RowLayoutProvider implements LayoutProvider {
  @override
  Widget buildLayout(List<Widget> children) => Row(
        mainAxisSize: MainAxisSize.max,
        children: children.map((f) => f.flex(1)).separate(SizedBox(width: 4)),
      );
}

mixin ListViewLayoutProvider implements LayoutProvider {
  @override
  Widget buildLayout(List<Widget> children) => ListView(
        children: children.separate(
          SizedBox(height: 4),
        ),
      );
}

// mixin ComplexLayoutMixin implements LayoutMixin {
//   @override
//   Widget buildLayout(PropMixin prop) => _ComplexView(prop);
// }

// class _ComplexView extends StatefulWidget {
//   final Prop prop;

//   const _ComplexView(this.prop);

//   @override
//   __ComplexViewState createState() => __ComplexViewState();
// }

// class __ComplexViewState extends State<_ComplexView> {
//   bool collapsed = false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(widget.prop.label).expand(),
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 onAdd(context);
//               },
//             ),
//             widget.prop.type == PropType.permanant
//                 ? SizedBox()
//                 : DeleteIcon(onDelete: widget.prop.disable),
//             IconButton(
//               icon:
//                   Icon(collapsed ? Icons.arrow_drop_down : Icons.arrow_drop_up),
//               onPressed: () {
//                 setState(() {
//                   this.collapsed = !collapsed;
//                 });
//               },
//             ),
//           ],
//         ),
//         !collapsed
//             ? Column(
//                 children: (widget.prop.box as CompositeBox)
//                     .props
//                     .map((prop) => prop.field)
//                     .toList(),
//               )
//             : SizedBox(),
//       ],
//     );
//   }

//   void onAdd(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => _PropsDialog(
//         props: (widget.prop.box as CompositeBox)
//             .props
//             .where((prop) => prop.type == PropType.absent)
//             .toList(),
//       ),
//     );
//   }
// }

// class _PropsDialog extends StatelessWidget {
//   final List<Prop> props;

//   const _PropsDialog({Key key, this.props}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         child: ListView.builder(
//           itemCount: props.length,
//           itemBuilder: (BuildContext context, int index) => ListTile(
//             title: Text(props[index].label),
//             onTap: () {
//               props[index].enable();
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// mixin MultiLayoutMixin implements LayoutMixin {
//   @override
//   Widget buildLayout(PropMixin prop) => _MultiView(prop);
// }

// class _MultiView extends StatefulWidget {
//   final PropMixin prop;

//   const _MultiView(this.prop);

//   @override
//   _MultiViewState createState() => _MultiViewState();
// }

// class _MultiViewState extends State<_MultiView> {
//   bool collapsed = false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(widget.prop.label).expand(),
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 onAdd(context);
//               },
//             ),
//             widget.prop.type == PropType.permanant
//                 ? SizedBox()
//                 : DeleteIcon(onDelete: widget.prop.disable),
//             IconButton(
//               icon:
//                   Icon(collapsed ? Icons.arrow_drop_down : Icons.arrow_drop_up),
//               onPressed: () {
//                 setState(() {
//                   this.collapsed = !collapsed;
//                 });
//               },
//             ),
//           ],
//         ),
//         !collapsed
//             ? Column(
//                 children: (widget.prop.box as MultiBox)
//                     .boxes
//                     .map((box) => box.buildField(Prop(label: '', box: box)))
//                     .toList(),
//               )
//             : SizedBox(),
//       ],
//     );
//   }

//   void onAdd(BuildContext context) {
//     final box = widget.prop.box as MultiBox;
//     box.append(box.onAdd());
//     setState(() {});
//   }
// }
