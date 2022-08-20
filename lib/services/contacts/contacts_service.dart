import 'package:flutter_contacts/contact.dart';

class AppContact extends Contact {
  AppContact({
    super.id,
    super.displayName,
    super.emails,
    super.phones,
  });
}

abstract class ContactsService {
  Future<List<AppContact>?> fetchContacts();
}
