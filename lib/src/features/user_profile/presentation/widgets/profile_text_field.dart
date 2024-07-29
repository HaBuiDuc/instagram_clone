import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool readOnly;
  final String label;
  final bool autofocus;
  final int line;
  final bool canRequestFocus;
  final double padding;
  final VoidCallback? onPressed;
  const ProfileTextField({
    super.key,
    this.controller,
    this.readOnly = false,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.line = 1,
    this.padding = 0,
    this.onPressed,
    required this.label,
  });
  static _border([Color color = ColorPalette.black]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: line,
      onTap: onPressed,
      controller: controller,
      autofocus: autofocus,
      canRequestFocus: canRequestFocus,
      readOnly: readOnly,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: ColorPalette.black),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: _border(ColorPalette.dimGray),
        focusedBorder: _border(),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: padding),
      ),
    );
  }
}
