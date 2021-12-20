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
  static final globalKey = GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.GetProgressDialog(
      ProgressDialogTitles.CreatingContact, false);
  TextEditingController nameController = TextEditingController(text:"");
  TextEditingController idnumberController = TextEditingController(text:"");
  TextEditingController ctController = TextEditingController(text:"");
  TextEditingController jobController = TextEditingController(text:"");
  TextEditingController phoneController = TextEditingController(text:"");
  Widget createContactWidget = Container();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    createContactWidget = ListView(
      reverse: true,
      children: <Widget>[
         Center(
          child: Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
            children: <Widget> [
              formContainer()
            ]
          )
        )
        )
      ]
    );
    return Scaffold(
      key:globalKey,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap:(){
            Navigator.pop(context, Events.UserHasNotCreatedAnyContact);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: const Text(Texts.CreateContact),
        actions: <Widget>[
          GestureDetector(
              onTap:()=> validCreateContactForm(),
              child: const Icon(
                Icons.done,
                size:30.0,
              ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          createContactWidget, progressDialog
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
  Widget formField(TextEditingController textEditingController,
      IconData icon, String text, TextInputType textInputType){
      return  TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          suffixIcon:  Icon(
            icon,
            color: Colors.blue,
          ),
          labelText: text,
          labelStyle: const TextStyle(fontSize: 18.0),
        ),
        keyboardType: textInputType,
      );
  }
  Widget formContainer(){
    return Form(
      child: Theme(
        data: ThemeData(primarySwatch: Colors.brown),
        child: Column(
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
    );
  }
  void validCreateContactForm(){
      String name = nameController.text;
      String id_number = idnumberController.text;
      String ct = ctController.text;
      String job = jobController.text;
      String phone = phoneController.text;
      FocusScope.of(context).requestFocus(FocusNode());
      Contact contactToBeCreated = Contact(
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
        //print(contactObject.id);
        switch (contactObject.id) {
          case Events.ContactWasCreatedSuccessfully:
            Navigator.pop(context, Events.ContactWasCreatedSuccessfully);
            break;
          case Events.UnableToCreateContact:
            Navigator.pop(context, Events.UnableToCreateContact);
            break;
          case Events.NoInternetConnection:
            const SnackBar(content: Text('NoInternetConnection'));
            break;
        }
      });
    }
  }
}
