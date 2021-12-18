import 'package:fish/DB/Common.dart';
import 'package:fish/utils/Contact.dart';

import '../utils/MyLib.dart';
import '../utils/ProgressDialog.dart';
import '../utils/Constants.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import '../utils/NoContent.dart';

class SearchContactsPages extends StatefulWidget {
  late  _SearchContactsPagesState _SearchContactsPage;
  @override
  createState() => _SearchContactsPage = new _SearchContactsPagesState();
  void resetSearchContactsPage(){
    _SearchContactsPage.resetSearchContacts();
  }
}

class _SearchContactsPagesState extends State<SearchContactsPages> {
  static final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.GetProgressDialog(
      ProgressDialogTitles.SearchingContacts, false);

  TextEditingController searchController = new TextEditingController(text: "");

  static const opacityCurve =
  const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  List<Contact> contactList = <Contact>[];

  late Widget contactListWidget;
  late Widget searchBar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        textTheme: new TextTheme(
            subtitle1: new TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            )),
        iconTheme: new IconThemeData(color: Colors.white),
        title: new TextFormField(
          controller: searchController,
          style: new TextStyle(color: Colors.white, fontSize: 20.0),
          onFieldSubmitted: (text) {
            searchThis(text);
          },
        ),
        actions: <Widget>[
          new GestureDetector(
            child: new Container(
              child: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              margin: EdgeInsets.only(right: 10.0),
            ),
            onTap: () {
              searchThis(searchController.text);
            },
          )
        ],
      ),
      key: globalKey,
      body: loadSearchPage(),
      backgroundColor: Colors.grey[150],
    );
  }

  void searchThis(String search) {
    if (searchController.text != "") {
      FocusScope.of(context).requestFocus(new FocusNode());
      progressDialog.Show();
      searchContacts(searchController.text);
    } else {
      SnackBar(content: Text('PLEASE_FILL_SOMETHING_IN_SEARCH_FIElD'));
    }
  }

  Widget loadSearchPage() {
    if (contactList != null) {
      if (contactList.isNotEmpty) {
        contactListWidget = new Container(
            margin: const EdgeInsets.all(16.0), child: _buildContactList());
      } else {
        contactListWidget = new Container(
            margin: const EdgeInsets.all(16.0),
            child: NoContentFound(Texts.NoContacts, Icons.account_circle));
      }
    }
    return new Stack(
      children: <Widget>[contactListWidget, progressDialog],
    );
  }

  Widget _buildContactList() {
    return new ListView.builder(
      itemBuilder: (context, i) {
        return _buildContactRow(contactList[i]);
      },
      itemCount: contactList.length,
    );
  }

  Widget _buildContactRow(Contact contact) {
    return new GestureDetector(
      onTap: () {
        _heroAnimation(contact);
      },
      child: new Card(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  contactAvatar(contact),
                  contactDetails(contact)
                ],
              ),
            ],
          ),
          margin: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  Widget contactAvatar(Contact contact) {
    return new Hero(
      tag: contact.id,
      child: Icon(Icons.account_box),
      createRectTween: (begin, end) =>
          MaterialRectCenterArcTween(begin: begin, end: end),
    );
  }

  Widget contactDetails(Contact contact) {
    return new Flexible(
        child: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              textContainer(contact.name, Colors.blue),
              textContainer(contact.phone, Colors.blueGrey),
            ],
          ),
          margin: EdgeInsets.only(left: 20.0),
        ));
  }

  Widget textContainer(String string, Color color) {
    return new Container(
      child: new Text(
        string,
        style: TextStyle(
            color: color, fontWeight: FontWeight.normal, fontSize: 16.0),
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }

  void _heroAnimation(Contact contact) {
    Navigator.of(context).push(
      PageRouteBuilder<Null>(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return new Opacity(
                  opacity: opacityCurve.transform(animation.value),
                  child: contactDetails(contact),
                );
              });
        },
      ),
    );
  }


  void resetSearchContacts() {
    setState(() {
      searchController.text = "";
      contactList = <Contact>[];
    });
  }

  void searchContacts(String searchQuery) async {
    EventObject eventObject = await searchContactsAvailable(searchQuery);
    if (this.mounted) {
      setState(() {
        progressDialog.Hide();
        switch (eventObject.id) {
          case Events.SearchContactsSuccessful:
            contactList = eventObject.object as List<Contact>;
            SnackBar(content: Text('CONTACTS_SEARCHED_SUCCESSFULLY'));
            break;
          case Events.NoContactForYourSearchQuery:
            contactList = <Contact>[];
            SnackBar(content: Text('NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY' +
                searchQuery));
            break;

          case Events.NoInternetConnection:
            contactList = <Contact>[];
            SnackBar(content: Text('NO_INTERNET_CONNECTION'));
            break;
        }
      });
    }
  }
}
