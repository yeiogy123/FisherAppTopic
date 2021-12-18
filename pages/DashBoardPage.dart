import '../utils/MyLib.dart';
import 'dart:async';
import 'package:fish/utils/Contact.dart';
import 'package:fish/utils/ProgressDialog.dart';
import 'RecordPage.dart';
import '../utils/Constants.dart';
import 'package:fish/DB/Common.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'CreateRecordPage.dart';
import 'SearchContactPage.dart';
import '../utils/NoContent.dart';
class DashBoardPage extends StatefulWidget {
  @override
  createState() => new DashBoardPageState();
}

class DashBoardPageState extends State<DashBoardPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog = ProgressDialog.GetProgressDialog(
      ProgressDialogTitles.LoadingContacts, true);
  Widget dashBoardWidget = new Container();
  String title = 'Record';
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await initContacts();
  }

  Future<void> initContacts() async {
    EventObject eventObjectInitContacts = await getContacts();
    eventsCapturing(eventObjectInitContacts);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return new Scaffold(
      key: globalKey,
      appBar: new AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(title),
      ),
      body: _apiHomePage(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _apiHomePage() {
    return new Stack(
      children: <Widget>[dashBoardWidget, progressDialog],
    );
  }

  Widget _floatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: new FloatingActionButton(
            onPressed: () {
              navigateToPage(new SearchContactsPages());
            },
            heroTag: 'Search Record',
            tooltip: 'Search Record',
            child: new Icon(
              Icons.search,
            ),
          ),
        ),
        new FloatingActionButton(
          onPressed: () {
            _navigateToCreateContactPage(context);
          },
          child: new Icon(
            Icons.add,
          ),
          heroTag: 'Search Record',
          tooltip: 'Search Record',
        ),
      ],
    );
  }

  void _navigateToCreateContactPage(BuildContext context) async {
    int contactCreationStatus = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new CreateRecordPage()),
    );
    setState(() {
      switch (contactCreationStatus) {
        case Events.ContactWasCreatedSuccessfully:
          handleNavigationDrawerClicks('CONTACTS', false);
          SnackBar(content:Text('CONTACT_WAS_CREATED_SUCCESSFULLY'));
          break;
        case Events.UnableToCreateContact:
          SnackBar(content: Text('UNABLE_TO_CREATE_CONTACT'));
          break;
        case Events.UserHasNotCreatedAnyContact:
          SnackBar(content:Text('USER_HAS_NOT_PERFORMED_ANY_ACTION'));
          break;
      }
    });
  }

  void handleNavigationDrawerClicks(String whatToDo, bool closeDrawer) {
    setState(() {
      if (closeDrawer) {
        Navigator.pop(context);
      }
      if (whatToDo != 'TAPPED_ON_HEADER') {
        Type type = dashBoardWidget.runtimeType;
        if (title == whatToDo) {
          if (type == RecordPage) {
            RecordPage recordpage = dashBoardWidget as RecordPage;
            recordpage.reloadContactList();
          }
        } else {
          title = whatToDo;
          switch (title) {
            case 'CONTACTS':
              progressDialog
                  .ShowProgressWithText(ProgressDialogTitles.LoadingContacts);
              loadContacts();
              break;
            case 'GO_BACK':
              Navigator.pop(context);
              break;
          }
        }
      } else {
        SnackBar(content:(Text('TAPPED_ON_SQF_LITE_HEADER')));
      }
    });
  }

  void loadContacts() async {
    EventObject eventObjectContacts = await getContacts();
    eventsCapturing(eventObjectContacts);
  }


  void eventsCapturing(EventObject eventObject) {
    if (this.mounted) {
      setState(() {
        progressDialog.Hide();
        switch (eventObject.id) {
          case Events.ReadContactsSuccessful:
            dashBoardWidget = new RecordPage(contactList: eventObject.object as List<Contact>);
            SnackBar(content:Text('CONTACTS_LOADED_SUCCESSFULLY'));
            break;
          case Events.NoContactsFound:
            dashBoardWidget = new RecordPage(contactList: <Contact>[]);
            SnackBar(content: Text('NO_CONTACTS_FOUND'));
            break;
          case Events.NoInternetConnection:
            dashBoardWidget = NoContentFound(
                'NO_INTERNET_CONNECTION', Icons.signal_wifi_off);
            SnackBar(content:Text('NO_INTERNET_CONNECTION'));
        }
      });
    }
  }
  void navigateToPage(StatefulWidget statefulWidget) {
    if (this.mounted) {
      setState(() {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => statefulWidget),
        );
      });
    }
  }
}