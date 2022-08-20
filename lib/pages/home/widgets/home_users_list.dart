import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/entities/user_entity.dart';
import 'package:github_profiles/services/contacts/contacts_service.dart';

class HomeUsersList extends StatelessWidget {
  final List<UserEntity> users;
  final List<AppContact>? contacts;

  const HomeUsersList({
    Key? key,
    required this.users,
    this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          title: Text(
            users[index].login,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
          trailing: _checkIfUserIsInContacts(user)
              ? RawMaterialButton(
                  onPressed: () => _callNumber(context, user),
                  elevation: 2.0,
                  fillColor: Colors.green,
                  padding: const EdgeInsets.all(12.0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.phone,
                    size: 22.0,
                  ),
                )
              : null,
          onTap: () => router.pushNamed('/profile/${user.login}'),
        );
      },
      separatorBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(height: 1, color: borderColor),
      ),
    );
  }

  bool _checkIfUserIsInContacts(UserEntity user) {
    return contacts?.any((contact) => contact.displayName == user.login) ??
        false;
  }

  void _callNumber(BuildContext context, UserEntity user) {
    final contact =
        contacts?.singleWhere((contact) => contact.displayName == user.login);
    if (contact != null && contact.phones.isNotEmpty) {
      final phoneNumber = contact.phones.first;
      lauchUrl(
        context: context,
        url: phoneNumber.number,
        protocol: LauchProtocol.tel,
      );
    }
  }
}
