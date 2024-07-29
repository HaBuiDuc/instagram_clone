// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? avatarUrl;
  final double size;
  const UserAvatar({
    super.key,
    required this.avatarUrl,
    this.size = 96
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: (avatarUrl == null)
          ? Image.asset(
              'assets/images/default_avatar.png',
              width: size,
              height: size,
            )
          : Image.network(
              avatarUrl!,
              width: size,
              height: size,
            ),
    );
  }
}
