
import 'dart:async';

import '../utils/Contact.dart';
import '../utils/Constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Common.dart';
class ContactsDatabase {
  static final ContactsDatabase _contactsDatabase =
  new ContactsDatabase._internal();

  ContactsDatabase._internal();

  late Database _database;

  static ContactsDatabase get() {
    return _contactsDatabase;
  }

  bool didInit = false;

  Future<Database> _getDb() async {
    if (!didInit) await _initDatabase();
    return _database;
  }

  /**
   * if exists, deletes.
   * else, creates.
   */
  Future _initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mydatabase.db');
    _database = await openDatabase(
        path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, id_number TEXT, ct T)'
          );
          await _createContactTable(db);

        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          await db.execute("DROP TABLE ${'user'}");
          await _createContactTable(db);
        });
    didInit = true;
  }

  Future _createContactTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute(CreateContactTable);
    });
  }

  Future<EventObject> getContactsUsingDB() async {
    try {
      var db = await ContactsDatabase.get()._getDb();
      List<Map> contactsMap =
      await db.rawQuery("Select * from ${'user'}");
      List<Contact> contacts = <Contact>[];
      if (contactsMap.isNotEmpty) {
        for (int i = 0; i < contactsMap.length; i++) {
          contacts.add(Contact.fromMap(contactsMap[i]));
        }
        return EventObject(id: Events.ReadContactsSuccessful, object: contacts);
      } else {
        return EventObject(id: Events.NoContactsFound);
      }
    } catch (e) {
      print(e.toString());
      return new EventObject(id: Events.NoContactsFound);
    }
  }

  Future<EventObject> saveContactUsingDB(Contact contact) async {
    try {
      var db = await ContactsDatabase.get()._getDb();
      int affectedRows =
      await db.insert('user', contact.toMap());
      if (affectedRows > 0) {
        return EventObject(
          id: Events.ContactWasCreatedSuccessfully,
        );
      } else {
        return EventObject(id: Events.UnableToCreateContact);
      }
    } catch (e) {
      print(e.toString());
      return new EventObject(id: Events.UnableToCreateContact);
    }
  }

  Future<EventObject> removeContactUsingDB(Contact contact) async {
    try {
      var db = await ContactsDatabase.get()._getDb();

      int affectedRows = await db.delete('user',
          where: "${ContactTable.name}=?", whereArgs: [contact.name]);
      if (affectedRows > 0) {
        return EventObject(
          id: Events.ContactWasDeletedSuccessfully,
        );
      } else {
        return EventObject(
            id: Events.NoContactWithProvidedIdExistInDB);
      }
    } catch (e) {
      print(e.toString());
      return new EventObject(id: Events.UnableToDeleteContact);
    }
  }

  Future<EventObject> updateContactUsingDB(Contact contact) async {
    try {
      var db = await ContactsDatabase.get()._getDb();
      int affectedRows = await db.update('user', contact.toMap(),
          where: "${ContactTable.name}=?", whereArgs: [contact.name]);

      if (affectedRows > 0) {
        return EventObject(
          id: Events.ContactWasUpdatedSuccessfully,
        );
      } else {
        return EventObject(
            id: Events.NoContactWithProvidedIdExistInDB);
      }
    } catch (e) {
      print(e.toString());
      return new EventObject(id: Events.UnableToUpdateContact);
    }
  }

  Future<EventObject> searchContactsUsingDB(String searchQuery) async {
    try {
      var db = await ContactsDatabase.get()._getDb();

      //Like query not used here in searching cuz its not working for sqflite
      List<Map> contactsMap =
      await db.rawQuery("Select * from ${'user'}");

      List<Contact> contacts = <Contact>[];
      if (contactsMap.isNotEmpty) {
        for (int i = 0; i < contactsMap.length; i++) {
          contacts.add(Contact.fromMap(contactsMap[i]));
        }
        List<Contact> searchedContacts = <Contact>[];
        for (Contact contact in contacts) {
          if (contact.name.contains(searchQuery) ||
              contact.phone.contains(searchQuery)) {
            searchedContacts.add(contact);
          }
        }
        if (searchedContacts.isNotEmpty) {
          return EventObject(
              id: Events.SearchContactsSuccessful, object: searchedContacts);
        } else {
          return EventObject(id: Events.NoContactForYourSearchQuery);
        }
      } else {
        return EventObject(id: Events.NoContactForYourSearchQuery);
      }
    } catch (e) {
      print(e.toString());
      return new EventObject(id: Events.NoContactForYourSearchQuery);
    }
  }
}