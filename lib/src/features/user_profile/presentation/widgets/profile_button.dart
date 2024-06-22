import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';

class ProfileButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final VoidCallback onPressed;
  const ProfileButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = ColorPalette.white,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 34,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(
                color: ColorPalette.black,
                width: 1.0,
              ),
            ),
            backgroundColor: backgroundColor,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: (backgroundColor == ColorPalette.white)
                  ? ColorPalette.black
                  : ColorPalette.white,
            ),
          ),
        ),
      ),
    );
  }
}
