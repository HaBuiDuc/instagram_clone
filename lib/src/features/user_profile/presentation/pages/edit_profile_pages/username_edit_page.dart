import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/edit_profile_app_bar.dart';
import 'package:instagram_clone/src/features/user_profile/presentation/widgets/profile_text_field.dart';

class UsernameEditPage extends StatefulWidget {
  final UserEntity userEntity;
  const UsernameEditPage({super.key, required this.userEntity});

  @override
  State<UsernameEditPage> createState() => _UsernameEditPageState();
}

class _UsernameEditPageState extends State<UsernameEditPage> {
  late final TextEditingController _usernameController;
  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.userEntity.userName);
  }

  void _onSubmit() {
    if (_usernameController.text != widget.userEntity.userName) {
      context
          .read<UserProfileBloc>()
          .add(UpdatingUserEvent(username: _usernameController.text));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditProfileAppBar(
        onSubmit: _onSubmit,
        title: 'Username',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileTextField(
              controller: _usernameController,
              label: 'Username',
              autofocus: true,
            )
          ],
        ),
      ),
    );
  }
}
