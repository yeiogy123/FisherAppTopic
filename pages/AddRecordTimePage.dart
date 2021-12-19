import 'package:mysql1/mysql1.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fisher"),
          leading: const Icon(FontAwesomeIcons.fish),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonTheme(
                    minWidth: 300.0,
                    height: 100,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TodayMode()));
                      },
                      child: const Text(
                        "Today",
                        style: TextStyle(fontSize: 20),
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 300.0,
                    height: 100,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OtherDayMode()));
                      },
                      child: const Text("Other Day",
                          style: TextStyle(fontSize: 20)),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class TodayMode extends StatelessWidget {
  const TodayMode({Key? key}) : super(key: key);

  init(DateTime startTime, DateTime finishTime, double workTime) async {
    String name = "kobe";
    //連結到Mysql資料庫
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'sql_turtorial',
        password: 'root'));
    print('connection success!!');
    //insert data into db
    var result = await conn.query(
        'insert into sql_turtorial.fisher(name, start_time, finish_time) values ("$name","$startTime","$finishTime","$workTime")');
    print('upload success!! ${result.insertId}');
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.now();
    DateTime finishTime = DateTime.now();
    int totalTime;
    double workTime;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Mode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(height: 50, width: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(
                        "Start time",
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                SizedBox(
                    height: 150,
                    width: 150,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      minuteInterval: 30,
                      initialDateTime: DateTime.now().add(
                        Duration(minutes: 30 - DateTime.now().minute % 30),
                      ),
                      onDateTimeChanged: (data) {
                        startTime = data;
                      },
                    )),
              ],
            ),
            const SizedBox(height: 50, width: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(
                        "Finish time",
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                SizedBox(
                    height: 150,
                    width: 150,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      minuteInterval: 30,
                      initialDateTime: DateTime.now().add(
                        Duration(minutes: 30 - DateTime.now().minute % 30),
                      ),
                      onDateTimeChanged: (data) {
                        finishTime = data;
                      },
                    )),
              ],
            ),
            const SizedBox(height: 50, width: 100),
            ButtonTheme(
                buttonColor: Colors.red,
                height: 50,
                minWidth: 100,
                child: RaisedButton(
                    onPressed: () {
                      print(startTime);
                      print(finishTime);
                      totalTime = finishTime.difference(startTime).inMinutes;
                      workTime = totalTime / 60;
                      print(workTime);
                      init(startTime, finishTime, workTime);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    ))),
            const SizedBox(height: 50, width: 100),
          ],
        ),
      ),
    );
  }
}

class OtherDayMode extends StatelessWidget {
  const OtherDayMode({Key? key}) : super(key: key);

  init(DateTime startTime, DateTime finishTime, double workTime) async {
    String name = "kobe";
    //連結到Mysql資料庫
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'sql_turtorial',
        password: 'root'));
    print('connection success!!');
    //insert data into db
    var result = await conn.query(
        'insert into sql_turtorial.fisher(name, start_time, finish_time) values ("$name","$startTime","$finishTime","$workTime")');
    print('upload success!! ${result.insertId}');
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.now();
    DateTime finshTime = DateTime.now();
    int totalTime;
    double workTime;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Other Day Mode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(height: 50, width: 100),
            const SizedBox(
                width: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    "Start time",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Expanded(
                child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              use24hFormat: true,
              minuteInterval: 30,
              initialDateTime: DateTime.now().add(
                Duration(minutes: 30 - DateTime.now().minute % 30),
              ),
              onDateTimeChanged: (data) {
                startTime = data;
              },
            )),
            const SizedBox(height: 50, width: 100),
            const SizedBox(
                width: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    "Finish time",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Expanded(
                child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              use24hFormat: true,
              minuteInterval: 30,
              initialDateTime: DateTime.now().add(
                Duration(minutes: 30 - DateTime.now().minute % 30),
              ),
              onDateTimeChanged: (data) {
                finshTime = data;
              },
            )),
            const SizedBox(height: 50, width: 100),
            ButtonTheme(
                buttonColor: Colors.red,
                height: 50,
                minWidth: 100,
                child: RaisedButton(
                    onPressed: () {
                      print(startTime);
                      print(finshTime);
                      totalTime = finshTime.difference(startTime).inMinutes;
                      workTime = totalTime / 60;
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    ))),
            const SizedBox(height: 50, width: 100),
          ],
        ),
      ),
    );
  }
}
