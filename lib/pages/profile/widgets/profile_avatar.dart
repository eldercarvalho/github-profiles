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
        Container(
          height: 216,
          color: onBackgroundColor,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: borderColor,
                  style: BorderStyle.solid,
                ),
              ),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
            ),
          ),
        )
      ],
    );
  }
}
