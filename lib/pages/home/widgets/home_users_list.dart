import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            child: Image.network(user.avatarUrl),
          ),
          title: Text(users[index].login),
          trailing:
              _checkIfUserIsInContacts(user) ? const Icon(Icons.check) : null,
          onTap: () => router.pushNamed('/profile/${user.login}'),
        );
      },
    );
  }

  bool _checkIfUserIsInContacts(UserEntity user) {
    return contacts?.any((contact) => contact.displayName == user.login) ??
        false;
  }
}
