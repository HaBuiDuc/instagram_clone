import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';

class EditProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onSubmit;
  const EditProfileAppBar({
    super.key,
    required this.title,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close),
      ),
      actions: [
        IconButton(
          onPressed: onSubmit,
          icon: const Icon(Icons.check),
          color: ColorPalette.shadeOfBlue,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
