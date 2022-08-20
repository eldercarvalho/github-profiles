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

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          title: Text(users[index].login,
              style: Theme.of(context).textTheme.headline6),
          trailing: _checkIfUserIsInContacts(user)
              ? const Icon(
                  Icons.phone_outlined,
                  color: Colors.green,
                )
              : null,
          onTap: () => router.pushNamed('/profile/${user.login}'),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }

  bool _checkIfUserIsInContacts(UserEntity user) {
    return contacts?.any((contact) => contact.displayName == user.login) ??
        false;
  }
}
