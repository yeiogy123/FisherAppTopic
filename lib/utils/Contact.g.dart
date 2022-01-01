part of 'Contact.dart';
Contact _$ContactFromJson(Map<String, dynamic> json) => new Contact(
  id: json['fisher_id'] as String,
  name: json['name'] as String,
  id_number: json['id_number'] as String,
  ct: json['ct'] as String,
  job: json['job'] as String,
  phone : json['phone'] as String,
);
abstract class _$ContactSerializerMixin{
  String get name;
  String get id;
  String get id_number;
  String get ct;
  String get job;
  String get phone;
  Map<String, dynamic> toJson()=> <String, dynamic>{
    'name':name,
    'id':id,
    'id_number':id_number,
    'ct':ct,
    'job':job,
    'phone':phone
  };
}