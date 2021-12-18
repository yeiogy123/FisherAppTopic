import 'dart:convert';
import 'dart:io';
import '../utils/MyLib.dart';
import '../utils/Constants.dart';
import '../utils/ProgressDialog.dart';
import '../utils/Contact.dart';
import '../DB/Common.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
class CreateRecordPage extends StatefulWidget {
  @override
  CreateRecordPageState createState() => CreateRecordPageState();
}
class CreateRecordPageState extends State<CreateRecordPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.GetProgressDialog(
      ProgressDialogTitles.CreatingContact, false);
  TextEditingController nameController = new TextEditingController(text:"");
  TextEditingController idnumberController = new TextEditingController(text:"");
  TextEditingController ctController = new TextEditingController(text:"");
  TextEditingController jobController = new TextEditingController(text:"");
  TextEditingController phoneController = new TextEditingController(text:"");
  Widget createCointactWidget = new Container();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    createCointactWidget = ListView(
      reverse: true,
      children: <Widget>[
        new Center(
          child:new Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: new Column(
            children: <Widget> [
              formContainer()
            ]
          )
        )
        )
      ]
    );
    return new Scaffold(
      key:globalKey,
      appBar: new AppBar(
        centerTitle: true,
        leading: new GestureDetector(
          onTap:(){
            Navigator.pop(context, Events.UserHasNotCreatedAnyContact);
          },
          child: new Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: new Text(Texts.CreateContact),
        actions: <Widget>[
          new GestureDetector(
              onTap:()=> validCreateContactForm(),
              child: new Icon(
                Icons.done,
                size:30.0,
              ),
          ),
        ],
      ),
      body: new Stack(
        children: <Widget>[
          createCointactWidget, progressDialog
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
  Widget formField(TextEditingController textEditingController,
      IconData icon, String text, TextInputType textInputType){
      return new Container(
        child: new TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            suffixIcon: new Icon(
              icon,
              color: Colors.blue,
            ),
            labelText: text,
            labelStyle: TextStyle(fontSize: 18.0),
          ),
          keyboardType: textInputType,
        ),
      );
  }
  Widget formContainer(){
    return new Container(
      child: new Form(
        child: new Theme(
          data: new ThemeData(primarySwatch: Colors.brown),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children:<Widget>[
              formField(nameController, Icons.face,
                  Texts.Name, TextInputType.text),//NAME
              formField(idnumberController, Icons.assignment_ind,
                  Texts.Id_number, TextInputType.text),//ID
              formField(ctController, Icons.attribution,
                  Texts.Ct, TextInputType.text),//CT
              formField(jobController, Icons.contact_page,
                  Texts.Job, TextInputType.text),//JOBBER
              formField(phoneController, Icons.phone,
                  Texts.Phone, TextInputType.text),//PHONENUM
            ]
          ),
        ),
      )
    );
  }
  void validCreateContactForm(){
      String name = nameController.text;
      String id_number = idnumberController.text;
      String ct = ctController.text;
      String job = jobController.text;
      String phone = phoneController.text;
      FocusScope.of(context).requestFocus(new FocusNode());
      Contact contactToBeCreated = new Contact(
          id:"",
          name:name,
          id_number: id_number,
          ct:ct,
          job:job,
          phone:phone
      );
      progressDialog.Show();
      createContact(contactToBeCreated);
  }
  void createContact(Contact contactToBeCreated) async{
    EventObject contactObject = await saveContact(contactToBeCreated);
    if(this.mounted) {
      setState(() {
        progressDialog.Hide();
        switch (contactObject.id) {
          case Events.ContactWasCreatedSuccessfully:
            Navigator.pop(context, Events.ContactWasCreatedSuccessfully);
            break;
          case Events.UnableToCreateContact:
            Navigator.pop(context, Events.UnableToCreateContact);
            break;
          case Events.NoInternetConnection:
            SnackBar(content: Text('NoInternetConnection'));
            break;
        }
      });
    }
  }
}
