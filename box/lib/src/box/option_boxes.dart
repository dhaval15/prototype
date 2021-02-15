import 'package:box/box.dart';
import 'package:box/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'core_box.dart';

abstract class OptionBox<T> = CoreBox<T>
    with OptionFieldProvider<T>, OptionConverter<T>, OptionJsonProvider;

class FontWeightBox = OptionBox<FontWeight> with FontWeightProvider;

class TextAlignBox = OptionBox<TextAlign> with TextAlignProvider;

class MainAxisAlignmentBox = OptionBox<MainAxisAlignment>
    with MainAxisAlignmentProvider;

class CrossAxisAlignmentBox = OptionBox<CrossAxisAlignment>
    with CrossAxisAlignmentProvider;

class MainAxisSizeBox = OptionBox<MainAxisSize> with MainAxisSizeProvider;

class VerticalDirectionBox = OptionBox<VerticalDirection>
    with VerticalDirectionProvider;

class FontStyleBox = OptionBox<FontStyle> with FontStyleProvider;
