import 'dart:async';
import 'package:fish/utils/Contact.dart';
import 'package:fish/DB/Common.dart';
import 'package:fish/DB/DB.dart';
import 'package:fish/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'Calender.dart';
import 'WorkingTable.dart';
import 'package:fish/DB/timeDB.dart';

DateTime datetime = DateTime.now();
// ignore: non_constant_identifier_names
int choose_day = datetime.day;
int choose_year = datetime.year;
int choose_month = datetime.month;
// ignore: non_constant_identifier_names
String day_text = ' ';
int who=0;


class Checkapp extends StatelessWidget {
  const Checkapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fisher",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[200],
          title: const Text('Month record',
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ),
        body:
        CheckPage(),
      ),
    );
  }
}

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);
  @override
  _CheckPageState createState() => _CheckPageState();
}

class People {
  //final String name;
  String name;
  //final String hr;
  String month_hr;

  String today_hr;

  People({required this.name, required this.month_hr, required this.today_hr});
}

List<People> listItems = [];

class _CheckPageState extends State<CheckPage> {
  //const _HomePageState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ToDB();
    return Center(
      child: Stack(
        children: [
          ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: InkWell(
                    child: Text(listItems[index].name[0]),
                    onTap: () {
                      jump_daywork(context, index);
                    }
                ),),
                title: Text(listItems[index].name),
                subtitle: Text(
                    'Today\'s working hour: ' + listItems[index].today_hr +
                        ' Month\'s working hour: ' + listItems[index].month_hr),
              );
            },
          ),
          Container(
              alignment: Alignment.topRight,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        jump_calender(context);
                      },
                      icon: const Icon(Icons.date_range, size: 36.0),
                    ),
                    Text(choose_day.toString(),
                        style: const TextStyle(fontSize: 45)),
                  ])),
        ],
      ),
    );
  }

  // jump to calender page
  // ignore: non_constant_identifier_names
  void jump_calender(BuildContext context) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => Calender(day: choose_day)));
    setState(() {
      choose_day = result;
    });
    day_text = choose_day.toString();
  }

  void jump_daywork(BuildContext context, who) {
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) =>
                Day_24hrPage(
                    name: listItems[who].name, c_day: choose_day)));
  }

  Future ToDB() async {
    ContactsDatabase c = ContactsDatabase.get();
    List<Contact> a = await c.getContactsForTime();
    listItems.clear();
    int a_length = a.toList().length;
    for (var i in a) {
      listItems.add(People(name: i.name, month_hr: '0', today_hr: '0'));
    }
    timeDatabase d = timeDatabase.get();
    List<Time> b = await d.usersGettime();
    for (int j = 0; j < b.toList().length; j++) {
      for (int k = 0; k < a_length; k++) {
        if (b.elementAt(j).name == listItems[k].name) {
          DateTime cmp = b.elementAt(j).startTime;
          if (cmp.month == choose_month && cmp.year == choose_year) {
            double temp = double.parse(listItems[k].month_hr);
            temp = temp + b.elementAt(j).workTime;
            listItems[k].month_hr = temp.toStringAsFixed(1);
            if (cmp.day == choose_day) {
              double today = double.parse(listItems[k].today_hr);
              today = today + b.elementAt(j).workTime;
              listItems[k].today_hr = today.toStringAsFixed(1);
            }
          }
        }
      }
    }
  }
}