import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/common/entities/user_entity.dart';
import 'package:instagram_clone/src/core/theme/color_palette.dart';

class SearchResultItem extends StatelessWidget {
  final UserEntity user;
  final void Function(UserEntity) onUserNavigate;
  const SearchResultItem(
      {super.key, required this.user, required this.onUserNavigate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onUserNavigate(user),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          width: double.infinity,
          child: Row(
            children: [
              ClipOval(
                child: (user.avatarUrl != null)
                    ? Image.network(
                        user.avatarUrl!,
                        width: 58,
                        height: 58,
                      )
                    : Image.asset(
                        'assets/images/default_avatar.png',
                        width: 58,
                        height: 58,
                      ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.dimGray,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
