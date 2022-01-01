import 'package:fish/DB/Common.dart';
import 'package:fish/pages/EditRecordPage.dart';
import 'package:fish/utils/NoContent.dart';
import 'package:flutter/scheduler.dart';

import '../utils/Constants.dart';
import '../utils/ProgressDialog.dart';
import '../utils/MyLib.dart';
import '../utils/Contact.dart';
import 'AddRecordTimePage.dart';
class RecordPage extends StatefulWidget {
  late List<Contact> contactList;
  late RecordPageState _RecordPageState;
  RecordPage({required this.contactList});
  @override
  createState()=> _RecordPageState = RecordPageState(contactList: contactList);
  void reloadContactList(){
    _RecordPageState.reloadContacts();
  }
}
class RecordPageState extends State<RecordPage> {
  List<Contact> contactList;
  late Widget contactListWidget;
  static final globalKey = GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog = ProgressDialog.GetProgressDialog(
      ProgressDialogTitles.CreatingContact, false);
  static const opacityCurve = Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);
  RecordPageState({required this.contactList});

  @override
  Widget build(BuildContext context){
    timeDilation = 3.0;
    return Scaffold(
      key: globalKey,
      body: loadList(),
      backgroundColor: Colors.white30,
    );
  }

  Widget loadList(){
    if(contactList != null && contactList.isNotEmpty) {
      contactListWidget = buildContactList();
    } else {
      contactListWidget = NoContentFound(Texts.NoContacts, Icons.account_circle);
    }
    return Stack(
      children: <Widget>[contactListWidget, progressDialog],
    );
  }
  Widget buildContactList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i)=>
        buildContactRow(contactList[i]),
      itemCount: contactList.length
    );
  }

  Widget buildContactRow(Contact contact){
    return Dismissible(
      key: Key(contact.name),
      child: GestureDetector(
        onTap: ()=> heroAnimation(contact),
        child: Card(
          margin: const EdgeInsets.only(top:10.0, bottom: 10.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    contactAvatar(contact),
                    contactDetail(contact)
                  ],
                )
              ],
            ),
            margin:const EdgeInsets.all(10.0)
          ),
        ),
      ),
      onDismissed: (direction)=>{
        setState((){
          if(direction == DismissDirection.endToStart){
            progressDialog.ShowProgressWithText(ProgressDialogTitles.DeletingContact);
            deleteContact(contact);
            contactList.remove(contact);
          }else{
            navigateToEditContactPage(context, contact);
            contactList.remove(contact);
          }
        })
      },
      direction: DismissDirection.horizontal,
      background: dismissContainerEdit(),
      secondaryBackground: dismissContainerDelete(),
    );
  }

  void navigateToEditContactPage(BuildContext context, Contact contact) async {
    int contactUpdateStatus = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditContactPage(contact))
    );
    setState(() {
      switch(contactUpdateStatus){
        case Events.ContactWasUpdatedSuccessfully:
          reloadContacts();
          const SnackBar(content: Text('ContactWasUpdatedSuccessfully'));
          break;
        case Events.UnableToUpdateContact:
          contactList.add(contact);
          const SnackBar(content: Text('UnableToUpdateContact'));
          break;
        default:
          contactList.add(contact);
          break;
      }
    });
  }
  Widget dismissContainerEdit(){
    return Card(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        alignment: Alignment.centerRight,
        color:  Colors.blue,
        child: Container(
          padding: const EdgeInsets.only(right:20.0),
          child: const Icon(
            Icons.edit,
            size: 40.0,
            color: Colors.grey,
          ),
        )
      ),
    );
  }

  Widget dismissContainerDelete(){
    return  Card(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
          alignment: Alignment.centerRight,
          color:  Colors.grey,
          child: Container(
            padding: const EdgeInsets.only(right:20.0),
            child: const Icon(
              Icons.delete,
              size: 40.0,
              color: Colors.grey,
            ),
          )
      ),
    );
  }

  Widget contactAvatar(Contact contact){
    return Hero(
      tag: contact.name,
      createRectTween: (begin, end)=> MaterialRectCenterArcTween(begin: begin, end:end),
      child: const Icon(
        Icons.accessibility,
      ),


    );
  }

  Widget contactDetail(Contact contact){
    return Flexible(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            textContainer(contact.name,Colors.blue),
            textContainer(contact.id,Colors.blue),
            textContainer(contact.ct,Colors.blue),
            textContainer(contact.job,Colors.blue),
            textContainer(contact.phone,Colors.blue),
          ],
        ),
        margin: const EdgeInsets.only(left: 20.0),
      ),
    );
  }

  Widget textContainer(String string, Color color){
    return Container(
      child: Text(
        string,
        style:TextStyle(
          color:color,
          fontWeight: FontWeight.normal,
          fontSize: 12.0
        ),
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      margin: const EdgeInsets.only(bottom:10.0),
    );
  }

  void heroAnimation(Contact contact){
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddRecordTimePage(contact: contact)));
  }

  void reloadContacts(){
    setState(() {
      progressDialog.ShowProgressWithText(ProgressDialogTitles.LoadingContacts);
      loadContacts();
    });
  }

  void loadContacts() async{
    EventObject eventObject = await getContacts();
    if(mounted){
      setState(() {
        progressDialog.Hide();
        switch(eventObject.id){
          case Events.ReadContactsSuccessful:
            //contactList = eventObject.object;
            const SnackBar(content:Text('ReadContactsSuccessful'));
            break;
          case Events.NoContactsFound:
            //contactList = eventObject.object;
            const SnackBar(content:Text('NoContactsFound'));
            break;
          case Events.NoInternetConnection:
            contactListWidget = NoContentFound(
              'NoInternetConnection', Icons.signal_wifi_off);
            const SnackBar(content: Text('NoInternetConnection'));
            break;
        }
      });
    }
  }
  void deleteContact(Contact contact) async{
    EventObject eventObject = await removeContact(contact);
    if(this.mounted){
      setState(() {
        progressDialog.Hide();
        switch(eventObject.id){
          case Events.ContactWasDeletedSuccessfully:
            const SnackBar(content: Text('ContactWasDeletedSuccessfully'));
            break;
          case Events.PleaseProvideTheIdOfTheContactToBeDeleted:
            contactList.add(contact);
            const SnackBar(content: Text('PleaseProvideTheIdOfTheContactToBeDeleted'));
            break;
          case Events.NoContactWithProvidedIdExistInDB:
            contactList.add(contact);
            const SnackBar(content: Text('NoContactWithProvidedIdExistInDB'));
            break;
          case Events.NoInternetConnection:
            contactList.add(contact);
            const SnackBar(content: Text('NoInternetConnection'));
        }
      });
    }
  }
}
