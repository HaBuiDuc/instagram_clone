import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/pages/edit_profile_pages/bio_edit_page.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/pages/edit_profile_pages/name_edit_page.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/pages/edit_profile_pages/username_edit_page.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/profile_text_field.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/user_avatar.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  void _onNavigate(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserAvatar(
              avatarUrl: user.avatarUrl,
              size: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Edit picture or avatar',
                style: TextStyle(
                  color: ColorPalette.shadeOfBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            ProfileTextField(
              label: 'Name',
              controller: TextEditingController(
                text: user.fullName,
              ),
              readOnly: true,
              canRequestFocus: false,
              onPressed: () => _onNavigate(NameEditPage(userEntity: user)),
            ),
            const SizedBox(
              height: 16,
            ),
            ProfileTextField(
              label: 'Username',
              controller: TextEditingController(
                text: user.userName,
              ),
              readOnly: true,
              canRequestFocus: false,
              onPressed: () => _onNavigate(
                UsernameEditPage(
                  userEntity: user,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ProfileTextField(
              label: 'Pronouns',
              controller: TextEditingController(
                text: user.userName,
              ),
              readOnly: true,
              canRequestFocus: false,
            ),
            const SizedBox(
              height: 16,
            ),
            ProfileTextField(
              label: 'Bio',
              controller: TextEditingController(
                text: user.userName,
              ),
              readOnly: true,
              canRequestFocus: false,
              onPressed: () => _onNavigate(BioEditPage(userEntity: user)),
            ),
          ],
        ),
      ),
    );
  }
}
