import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    // fontFamily: 'InstaSan',
    scaffoldBackgroundColor: ColorPalette.white,
    appBarTheme: const AppBarTheme(backgroundColor: ColorPalette.white),
  );
}
