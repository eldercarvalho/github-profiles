import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:github_profiles/entities/user_entity.dart';
import 'package:github_profiles/services/contacts/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';

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
          title: Text(users[index].login,
              style: Theme.of(context).textTheme.headline6),
          trailing: _checkIfUserIsInContacts(user)
              ? RawMaterialButton(
                  onPressed: () => _callNumber(user),
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
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }

  bool _checkIfUserIsInContacts(UserEntity user) {
    return contacts?.any((contact) => contact.displayName == user.login) ??
        false;
  }

  void _callNumber(UserEntity user) async {
    final contact =
        contacts?.singleWhere((contact) => contact.displayName == user.login);
    if (contact != null && contact.phones.isNotEmpty) {
      final phoneNumber = contact.phones.first;
      await launchUrl(Uri.parse('tel:${phoneNumber.number}'));
    }
  }
}
