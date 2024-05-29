import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscured;
  final TextInputType keyboardType;

  OutlineInputBorder inputBorder([Color color = ColorPalette.grey]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          width: 0.1,
          color: color,
        ),
      );

  const AuthField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isObscured = false,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: ColorPalette.grey,
        filled: true,
        border: inputBorder(),
        enabledBorder: inputBorder(ColorPalette.dimGray),
        focusedBorder: inputBorder(ColorPalette.black),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      obscureText: isObscured,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: keyboardType,
    );
  }
}
