import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(color: ColorPalette.white),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
