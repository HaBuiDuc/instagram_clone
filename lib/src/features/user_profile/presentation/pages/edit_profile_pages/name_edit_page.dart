import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/edit_profile_app_bar.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/profile_text_field.dart';

class NameEditPage extends StatefulWidget {
  final UserEntity userEntity;
  const NameEditPage({super.key, required this.userEntity});

  @override
  State<NameEditPage> createState() => _NameEditPageState();
}

class _NameEditPageState extends State<NameEditPage> {
  late final TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userEntity.fullName);
  }

  void _onSubmit() {
    if (_nameController.text != widget.userEntity.fullName) {
      context
          .read<UserProfileBloc>()
          .add(UpdatingUserEvent(fullName: _nameController.text));
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
              controller: _nameController,
              label: 'Name',
              autofocus: true,
            )
          ],
        ),
      ),
    );
  }
}
