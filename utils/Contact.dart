import 'dart:async';
import 'Constants.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Contact.g.dart';
@JsonSerializable()
class Contact extends Object with _$ContactSerializerMixin{
  String name, id_number,id, ct, job, phone;
  Contact({
    required this.name,
    required this.id_number,
    required this.id,
    required this.ct,
    required this.job,
    required this.phone
  });
  static Future<List<Contact>> fromContactJson(List<dynamic> json)async{
    List<Contact> contactList = <Contact>[];
    for(var contact in json){
      contactList.add(new Contact(
          id: contact['fisher_id'],
          id_number: contact['id'],
          name: contact['name'],
          ct: contact['ct'],
          job: contact['job'],
          phone: contact['job']
      ));
    }
    return contactList;
  }
  factory Contact.fromjson(Map<String, dynamic> json)=> _$ContactFromJson(json);

  Map<String, dynamic> toMap(){
    Map<String, dynamic> contactMap = <String, dynamic>{
      ContactTable.name: name,
      ContactTable.id_number: id_number,
      ContactTable.ct: ct,
      ContactTable.job : job,
      ContactTable.phone: phone
    };
    return contactMap;
  }
  static Contact fromMap(Map map){
    return new Contact(
        id: map[ContactTable.fisher_id],
        name: map[ContactTable.name],
        id_number:map[ContactTable.id_number],
        ct:map[ContactTable.ct],
        job:map[ContactTable.job],
        phone:map[ContactTable.phone]
    );
  }
}
