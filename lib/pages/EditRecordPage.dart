import 'package:fish/DB/Common.dart';
import 'package:flutter/scheduler.dart';

import '../utils/ProgressDialog.dart';

import '../utils/MyLib.dart';
import '../utils/Contact.dart';
import '../utils/Constants.dart';
class EditContactPage extends StatefulWidget {
  Contact contact;
  EditContactPage(this.contact);

  @override
  createState() => EditContactPageState(contact);
}

class EditContactPageState extends State<EditContactPage> {
  static final globalKey = GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.GetProgressDialog(
      'EDITING_CONTACT', false);

  Contact contact;


  late TextEditingController nameController;
  late TextEditingController fisherIdController;
  late TextEditingController ctController;
  late TextEditingController jobController;
  late TextEditingController phoneController;

  Widget editContactWidget = Container();

  int validCount = 0;

  EditContactPageState(this.contact);

  @override
  void initState() {
    nameController = TextEditingController(text: contact.name);
    fisherIdController = TextEditingController(text: contact.id_number);
    ctController =  TextEditingController(text: contact.ct);
    jobController = TextEditingController(text: contact.job);
    phoneController = TextEditingController(text: contact.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    editContactWidget = ListView(
      reverse: true,
      children: <Widget>[
        Center(
          child: Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              children: <Widget>[
                _formContainer(),
              ],
            ),
          ),
        )
      ],
    );
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, Events.UserHasNotPerformedUpdateAction);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
        ),
        textTheme:TextTheme(
            subtitle1: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            )),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(Texts.EditContact),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _validateEditContactForm();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.done,
                size: 30.0,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[editContactWidget, progressDialog],
      ),
      backgroundColor: Colors.grey[150],
    );
  }

  Widget _formContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Form(
          child: Theme(
              data: ThemeData(primarySwatch: Colors.blue),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _formField(nameController, Icons.face,
                  Texts.Name, TextInputType.text),//NAME
                  _formField(fisherIdController, Icons.assignment_ind,
                  Texts.Id_number, TextInputType.text),//ID
                  _formField(ctController, Icons.attribution,
                  Texts.Ct, TextInputType.text),//CT
                  _formField(jobController, Icons.contact_page,
                  Texts.Job, TextInputType.text),//JOBBER
                  _formField(phoneController, Icons.phone,
                  Texts.Phone, TextInputType.text),
                ],
              ))),
    );
  }

  Widget _formField(TextEditingController textEditingController, IconData icon,
      String text, TextInputType textInputType) {
    return Container(
        child:  TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
              suffixIcon: Icon(
                icon,
                color: Colors.blue[400],
              ),
              labelText: text,
              labelStyle: const TextStyle(fontSize: 18.0)),
          keyboardType: textInputType,
        ),
        margin: const EdgeInsets.only(bottom: 10.0));
  }

  void _validateEditContactForm() {

    String name = nameController.text;
    String fisherId = fisherIdController.text;
    String ct = ctController.text;
    String job = jobController.text;
    String phone = phoneController.text;
    FocusScope.of(context).requestFocus(FocusNode());
    Contact contactToBeEdited = Contact(
      name:name,
      id_number: fisherId,
      ct:ct,
      job:job,
      phone:phone,
        id:""
    );
    progressDialog.Show();
    editContact(contactToBeEdited);
  }

  void editContact(Contact contactToBeEdited) async {
    EventObject contactObject = await updateContact(contactToBeEdited);
    if (this.mounted) {
      setState(() {
        progressDialog.Hide();
        switch (contactObject.id) {
          case Events.ContactWasUpdatedSuccessfully:
            Navigator.pop(context, Events.ContactWasUpdatedSuccessfully);
            break;
          case Events.UnableToUpdateContact:
            Navigator.pop(context, Events.UnableToUpdateContact);
            break;
          case Events.NoContactWithProvidedIdExistInDB:
            Navigator.pop(
                context, Events.NoContactWithProvidedIdExistInDB);
            break;
          case Events.NoInternetConnection:
            const SnackBar(content:Text('NO_INTERNET_CONNECTION'));
            break;
        }
      });
    }
  }
}