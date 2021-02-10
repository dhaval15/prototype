import 'package:box/src/providers/providers.dart';

import 'core_box.dart';
import 'package:flutter/material.dart';
import 'child_box.dart';
import 'composite_box.dart';
import 'multi_box.dart';

class StringBox = CoreBox<String> with StringFieldProvider, StringCodeProvider;
class DoubleBox = CoreBox<double> with DoubleFieldProvider, DoubleConverter;
class RadiusBox = CoreBox<Radius> with RadiusFieldProvider, RadiusConverter;
class IntBox = CoreBox<int> with IntFieldProvider, IntConverter;
class ColorBox = CoreBox<Color> with ColorFieldProvider, ColorConverter;
class ChildBox = BaseChildBox with ChildFieldProvider, ChildCodeProvider;
abstract class CompositeBox<T> = BaseCompositeBox<T>
    with CompositeFieldProvider, CompositeCodeProvider;
class MultiBox<T> = BaseMultiBox<T>
    with MultiFieldProvider<T>, MultiCodeProvider;
