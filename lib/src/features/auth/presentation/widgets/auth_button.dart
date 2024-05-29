import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: ColorPalette.shadeOfBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: ColorPalette.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
