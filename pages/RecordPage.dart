import 'package:fish/DB/Common.dart';
import 'package:fish/utils/NoContent.dart';
import 'package:flutter/scheduler.dart';

import '../utils/Constants.dart';
import '../utils/ProgressDialog.dart';
import '../utils/MyLib.dart';
import '../utils/Contact.dart';
import 'ChoosePage.dart';
class RecordPage extends StatefulWidget {
  late List<Contact> contactList;
  late RecordPageState _RecordPageState;
  RecordPage({required this.contactList});
  @override
  createState()=> _RecordPageState = new RecordPageState(contactList: contactList);
  void reloadContactList(){
    _RecordPageState.reloadContacts();
  }
}
class RecordPageState extends State<RecordPage> {
  List<Contact> contactList;
  late Widget contactListWidget;
  static final globalKey = new GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog = ProgressDialog.GetProgressDialog(
      ProgressDialogTitles.CreatingContact, false);
  static const opacityCurve = const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);
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
    if(contactList != null && contactList.isNotEmpty)
      contactListWidget = buildContactList();
    else
      contactListWidget = NoContentFound(Texts.NoContacts, Icons.account_circle);
    return new Stack(
      children: <Widget>[contactListWidget, progressDialog],
    );
  }
  Widget buildContactList(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i)=>
        buildContactRow(contactList[i]),
      itemCount: contactList.length
    );
  }

  Widget buildContactRow(Contact contact){
    return new Dismissible(
      key: Key(contact.name),
      child: new GestureDetector(
        onTap: ()=> heroAnimation(contact),
        child: new Card(
          margin: EdgeInsets.only(top:10.0, bottom: 10.0),
          child: new Container(
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    contactAvatar(contact),
                    contactDetail(contact)
                  ],
                )
              ],
            ),
            margin:EdgeInsets.all(10.0)
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
      MaterialPageRoute(builder: (context) => new ChoosePage()) // 改成editcontactpage
    );
    setState(() {
      switch(contactUpdateStatus){
        case Events.ContactWasUpdatedSuccessfully:
          reloadContacts();
          SnackBar(content: Text('ContactWasUpdatedSuccessfully'));
          break;
        case Events.UnableToUpdateContact:
          contactList.add(contact);
          SnackBar(content: Text('UnableToUpdateContact'));
          break;
        default:
          contactList.add(contact);
          break;
      }
    });
  }
  Widget dismissContainerEdit(){
    return new Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Container(
        alignment: Alignment.centerRight,
        color:  Colors.brown,
        child: new Container(
          padding: EdgeInsets.only(right:20.0),
          child: new Icon(
            Icons.edit,
            size: 40.0,
            color: Colors.grey,
          ),
        )
      ),
    );
  }

  Widget dismissContainerDelete(){
    return new Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Container(
          alignment: Alignment.centerRight,
          color:  Colors.grey,
          child: new Container(
            padding: EdgeInsets.only(right:20.0),
            child: new Icon(
              Icons.delete,
              size: 40.0,
              color: Colors.grey,
            ),
          )
      ),
    );
  }

  Widget contactAvatar(Contact contact){
    return new Hero(
      tag: contact.name,
      createRectTween: (begin, end)=>new MaterialRectCenterArcTween(begin: begin, end:end),
      child: Icon(
        Icons.accessibility,
      ),


    );
  }

  Widget contactDetail(Contact contact){
    return new Flexible(
      child: new Container(
        child: new Column(
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
        margin: EdgeInsets.only(left: 20.0),
      ),
    );
  }

  Widget textContainer(String string, Color color){
    return Container(
      child: new Text(
        string,
        style:TextStyle(
          color:color,
          fontWeight: FontWeight.normal,
          fontSize: 16.0
        ),
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      margin: EdgeInsets.only(bottom:10.0),
    );
  }

  void heroAnimation(Contact contact){
    Navigator.of(context).push(
      new PageRouteBuilder<Null>(
          pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation){
            return new AnimatedBuilder(
              animation: animation,
              builder: (context, child){
                return new Opacity(
                    opacity: opacityCurve.transform(animation.value),
                    child:contactDetail(contact)
                );}
            );
          }
      )
    );
  }

  void reloadContacts(){
    setState(() {
      progressDialog.ShowProgressWithText(ProgressDialogTitles.LoadingContacts);
      loadContacts();
    });
  }

  void loadContacts() async{
    EventObject eventObject = await getContacts();
    if(this.mounted){
      setState(() {
        progressDialog.Hide();
        switch(eventObject.id){
          case Events.ReadContactsSuccessful:
            //contactList = eventObject.object;
            SnackBar(content:Text('ReadContactsSuccessful'));
            break;
          case Events.NoContactsFound:
            //contactList = eventObject.object;
            SnackBar(content:Text('NoContactsFound'));
            break;
          case Events.NoInternetConnection:
            /*contactListWidget = NoContectFound(
              'NoInternetConnection', Icons.signal_wifi_off);
            )
             */
            SnackBar(content: Text('NoInternetConnection'));
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
            SnackBar(content: Text('ContactWasDeletedSuccessfully'));
            break;
          case Events.PleaseProvideTheIdOfTheContactToBeDeleted:
            contactList.add(contact);
            SnackBar(content: Text('PleaseProvideTheIdOfTheContactToBeDeleted'));
            break;
          case Events.NoContactWithProvidedIdExistInDB:
            contactList.add(contact);
            SnackBar(content: Text('NoContactWithProvidedIdExistInDB'));
            break;
          case Events.NoInternetConnection:
            contactList.add(contact);
            SnackBar(content: Text('NoInternetConnection'));
        }
      });
    }
  }
}
