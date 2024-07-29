import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';

class AppTheme {
  // static _border([Color color = ColorPalette.black]) => OutlineInputBorder(
  //       borderSide: BorderSide(
  //         color: color,
  //         width: 2,
  //       ),
  //       borderRadius: BorderRadius.circular(10),
  //     );
  static final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    // fontFamily: 'InstaSan',
    scaffoldBackgroundColor: ColorPalette.white,
    appBarTheme: const AppBarTheme(backgroundColor: ColorPalette.white),

  );
}
