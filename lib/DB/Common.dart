import 'dart:async';

import 'dart:ui';
import 'package:fish/utils/MyLib.dart';
import 'DB.dart';

import '../utils/Constants.dart';
import '../utils/Contact.dart';
ContactsDatabase DB = ContactsDatabase.get();
Future<EventObject> saveContact(Contact contact) async{
  EventObject eventObject = await DB.saveContactUsingDB(contact) as EventObject;
  print("save successfully.\n");
  return eventObject;
}
Future<EventObject> removeContact(Contact contact) async{
  EventObject eventobject = await DB.removeContactUsingDB(contact) as EventObject;
  return eventobject;
}
Future<EventObject> updateContact(Contact contact) async{
  EventObject eventObject = await DB.updateContactUsingDB(contact) as EventObject;
  return eventObject;
}
Future<EventObject> searchContact(String query) async {
  EventObject eventObject = await DB.searchContactsUsingDB(query) as EventObject;
  return eventObject;
}
Future<EventObject> getContacts() async{
  EventObject eventObject = await DB.getContactsUsingDB() as EventObject;
  print(eventObject.object);
  print('get successfully');
  return eventObject;
}
Future<EventObject> searchContactsAvailable(String query) async{
  EventObject eventObject = await DB.searchContactsUsingDB(query) as EventObject;
  return eventObject;
}