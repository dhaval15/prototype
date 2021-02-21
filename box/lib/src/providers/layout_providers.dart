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
