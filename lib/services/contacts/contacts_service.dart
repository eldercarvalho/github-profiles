import 'package:flutter_contacts/contact.dart';

class AppContact extends Contact {
  AppContact({
    super.id,
    super.displayName,
    super.emails,
  });
}

abstract class ContactsService {
  Future<List<AppContact>?> fetchContacts();
}
