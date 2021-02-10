import 'package:box/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'core_box.dart';

class FontWeightBox = CoreBox<FontWeight>
    with
        OptionFieldProvider<FontWeight>,
        FontWeightProvider,
        OptionConverter<FontWeight>;

class TextAlignBox = CoreBox<TextAlign>
    with
        OptionFieldProvider<TextAlign>,
        TextAlignProvider,
        OptionConverter<TextAlign>;

class MainAxisAlignmentBox = CoreBox<MainAxisAlignment>
    with
        OptionFieldProvider<MainAxisAlignment>,
        MainAxisAlignmentProvider,
        OptionConverter<MainAxisAlignment>;

class CrossAxisAlignmentBox = CoreBox<CrossAxisAlignment>
    with
        OptionFieldProvider<CrossAxisAlignment>,
        CrossAxisAlignmentProvider,
        OptionConverter<CrossAxisAlignment>;

class MainAxisSizeBox = CoreBox<MainAxisSize>
    with
        OptionFieldProvider<MainAxisSize>,
        MainAxisSizeProvider,
        OptionConverter<MainAxisSize>;

class VerticalDirectionBox = CoreBox<VerticalDirection>
    with
        OptionFieldProvider<VerticalDirection>,
        VerticalDirectionProvider,
        OptionConverter<VerticalDirection>;

class FontStyleBox = CoreBox<FontStyle>
    with
        OptionFieldProvider<FontStyle>,
        FontStyleProvider,
        OptionConverter<FontStyle>;
