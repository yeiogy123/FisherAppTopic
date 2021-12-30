import 'dart:async';

import 'package:fish/DB/Common.dart';
import 'package:fish/DB/DB.dart';
import 'package:fish/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'Calender.dart';
import 'WorkingTable.dart';

DateTime datetime = DateTime.now();
// ignore: non_constant_identifier_names
int choose_day = datetime.day;
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
  final String name;
  final String hr;

  People({required this.name, required this.hr});
}

List<People> listItems = [
  People(name: 'Andy', hr: '10'),
  People(name: 'Eddie', hr: '32'),
  People(name: 'Jane', hr: '45'),
  People(name: 'Unkko', hr: '42'),
  People(name: 'Odie', hr: '6'),
  People(name: 'Odysseus', hr: '17'),
  People(name: 'Cart', hr: '12'),
  People(name: 'Kane', hr: '32'),
  People(name: 'Grave', hr: '75'),
];

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
                subtitle: Text('Today\'s hour: ' + listItems[index].hr),
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
            builder: (context) => Day_24hr(name: listItems[who].name)));
  }

  Future ToDB() async {
    ContactsDatabase c = ContactsDatabase.get();
    await c.getContactsForTime();
  }
}
