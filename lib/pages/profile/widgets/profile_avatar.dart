import 'package:flutter/material.dart';

import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/entities/user_entity.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 216),
        Container(
          height: 116,
          color: onBackgroundColor,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
          ),
        )
      ],
    );
  }
}
