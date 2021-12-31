
import 'dart:async';

import '../utils/Contact.dart';
import '../utils/Constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mysql1/mysql1.dart';
import 'package:mysql_utils/mysql_utils.dart';
import 'Common.dart';
class ContactsDatabase {
  static ContactsDatabase _contactsDatabase = new ContactsDatabase();
  ContactsDatabase();
  late MySqlConnection connect;
  bool didinit = false;
  Future init() async{
    this.connect = await MySqlConnection.connect(ConnectionSettings(
        user: "root",
        password: "Lin15051780!",
        host: "10.0.2.2",
        port: 3306,
        db: "fish"
    ));
    await connect.query('CREATE TABLE `users` '
        '(`id` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,'
        '`name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,'
        '`fisher_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,'
        '`ct` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,'
        '`job` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,'
        '`phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,'
        'PRIMARY KEY(`name`))');
    didinit = true;
  }
  void close(){
    connect.close();
    didinit = false;
  }
  MySqlConnection getConnect(){
    return connect;
  }
  static ContactsDatabase get(){
    return _contactsDatabase;
  }
  Future _getDB() async{
    if(!didinit) await init();
    return connect;
  }
  Future <List<Contact>> getContactsForTime() async{
    try{
      var db = await _contactsDatabase._getDB();
      Results contact = await db.query('SELECT * FROM fish.users');
      List<Contact> contacts = <Contact>[];
      int complete = 0;
      for(var i in contact) {
        contacts.add(Contact.fromMap(i.fields));
      }
      return contacts;
    }catch(e){
      print('error');
      print(e.toString());
      return [];
    }
  }
  Future<EventObject> getContactsUsingDB() async {
    try {
      var db = await _contactsDatabase._getDB();
      Results contact =
      await db.query(
          'SELECT * FROM fish.users'
      );
      List<Contact> contacts = <Contact>[];
      int complete = 0;
      for(var i in contact) {
        contacts.add(Contact.fromMap(i.fields));
      }
      await db.close();
      complete = await 1;
      if (contacts.isNotEmpty) {
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
      var db = await _contactsDatabase._getDB();
      Results affectedRows =
      await db.query('insert into fish.users (name, fisher_id, ct, job, phone) values(?,?,?,?,?)',
          [contact.name, contact.id_number, contact.ct, contact.job, contact.phone]);
      if (affectedRows.isEmpty) {
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
      var db = await ContactsDatabase.get()._getDB();

      Results affectedRows = await db.delete(table:'user',
          where: {'name' : contact.name});
      if (affectedRows.isNotEmpty) {
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
      var db = await ContactsDatabase.get()._getDB();
      Results affectedRows = await db.update(
          table: 'user',
          updateData: contact.toMap(),
          where: {'name' : contact.name});

      if (affectedRows.isNotEmpty) {
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
      var db = await ContactsDatabase.get()._getDB();

      //Like query not used here in searching cuz its not working for sqflite
      List<Map> contactsMap =
      await db.getone(
          table:'user',
          where:{'name': searchQuery}
      );

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
