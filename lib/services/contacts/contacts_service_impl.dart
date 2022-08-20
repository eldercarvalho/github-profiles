import 'package:flutter_contacts/flutter_contacts.dart';

import 'contacts_service.dart';

class ContactsServiceImpl implements ContactsService {
  @override
  Future<List<AppContact>?> fetchContacts() async {
    try {
      final hasPermission = await FlutterContacts.requestPermission();

      if (!hasPermission) {
        return null;
      }

      final contacts = await FlutterContacts.getContacts();
      return contacts
          .map(
            (contact) => AppContact(
              id: contact.id,
              displayName: contact.displayName,
              emails: contact.emails,
              phones: contact.phones,
            ),
          )
          .toList();
    } catch (err, st) {
      print(err);
      print(st);
      return null;
    }
  }
}
