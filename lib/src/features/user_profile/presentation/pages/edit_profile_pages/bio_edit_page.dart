import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/edit_profile_app_bar.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/profile_text_field.dart';

class BioEditPage extends StatefulWidget {
  final UserEntity userEntity;
  const BioEditPage({super.key, required this.userEntity});

  @override
  State<BioEditPage> createState() => _BioEditPageState();
}

class _BioEditPageState extends State<BioEditPage> {
  late final TextEditingController _bioController;
  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: widget.userEntity.bio);
  }

  void _onSubmit() {
    if (_bioController.text != widget.userEntity.bio) {
      context
          .read<UserProfileBloc>()
          .add(UpdatingUserEvent(bio: _bioController.text));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditProfileAppBar(
        onSubmit: _onSubmit,
        title: 'Name',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileTextField(
              controller: _bioController,
              label: 'Name',
              autofocus: true,
              line: 4,
              padding: 8,
            )
          ],
        ),
      ),
    );
  }
}
