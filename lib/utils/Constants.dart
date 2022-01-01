class Events {
  static const int NoInternetConnection = 0;
  static const int ReadContactsSuccessful = 500;
  static const int NoContactsFound = 501;
  static const int DeletdContactsSuccessful = 502;
  static const int ContactWasCreatedSuccessfully = 503;
  static const int UnableToCreateContact = 504;
  static const int UserHasNotCreatedAnyContact = 505;
  static const int ContactWasUpdatedSuccessfully = 506;
  static const int UnableToUpdateContact = 507;
  static const int ContactWasDeletedSuccessfully = 508;
  static const int PleaseProvideTheIdOfTheContactToBeDeleted = 509;
  static const int NoContactWithProvidedIdExistInDB = 510;
  static const int SearchContactsSuccessful = 511;
  static const int NoContactForYourSearchQuery = 512;
  static const int UnableToDeleteContact = 513;
  static const int UserHasNotPerformedUpdateAction = 514;
}
class Texts {
  static const String AppName = "Contacts";
  static const String DeleteContact = "Delete Contact";
  static const String EditContact = "Edit Contact";
  static const String ContactDetails= "Contact Details";
  static const String CreateContact = "Create Contact";
  static const String NoContacts = "No Contacts";
  static const String NoDeletedContacts = "No Deleted Contacts";
  static const String NoLogs= "No Logs";
  static const String SaveContact = "Save Contact";
  static const String Name = "Name";
  static const String Id_number = 'Id_number';
  static const String Ct = 'Ct';
  static const String Job = 'Job';
  static const String Phone = 'Phone';
  static const String TypeSomethinghere = "Type Something here";
}
class ProgressDialogTitles {
  static const String LoadingContacts = "Contacts...";
  static const String DeletingContact = "Deleting...";
  static const String SearchingContacts = "Searching...";
  static const String CreatingContact = "Creating...";
  static const String EditingContact = "Editing...";
  static const String LoadingDeletedContacts = "Contacts...";
  static const String LoadingLogs = "Logs...";
}
class ContactTable {
  static const String fisher_id = 'fisher_id';
  static const String TableName = "user";
  static const String id_number = "id_number";
  static const String name = "name";
  static const String phone = "phone";
  static const String ct = "ct";
  static const String job = "job";
}
class TimeDataTable{
  static const String name = 'name';
  static const String startTime = 'startTime';
  static const String endTime = 'endTime';
  static const String workTime = 'workTime';
}
class EventObject{
  int id;
  Object object;
  EventObject({
    this.id : Events.NoInternetConnection,
    this.object : 0
  });
}
const String CreateContactTable =
  "CREATE TABLE" +
  ContactTable.TableName +
      "("+ ContactTable.fisher_id+
      "INTEGER PRIMARY KEY AUTOINCREMENT" +
      ContactTable.name+
      "TEXT NOT NULL,"+
      ContactTable.id_number+
      "TEXT NOT NULL,"+
      ContactTable.ct+
      "TEXT NOT NULL,"+
      ContactTable.job+
      "TEXT NOT NULL,"+
      ContactTable.phone+
      "TEXT NOT NULL,"+
      ");";
