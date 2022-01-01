import 'package:fish/DB/timeDB.dart';
import 'package:fish/utils/Contact.dart';
import 'package:fish/utils/MyLib.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
timeDatabase TDB = timeDatabase.get();
class AddRecordTimePage extends StatefulWidget {

  late String title;
  late Contact contact;
  AddRecordTimePage({required this.contact});
  @override
  _AddRecordPageState createState() => _AddRecordPageState(contact:contact);
}

class _AddRecordPageState extends State<AddRecordTimePage> {
  late Contact contact;
  _AddRecordPageState({
    required this.contact});
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
                            builder: (context) => TodayMode(contact: contact)));
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
                            builder: (context) => OtherDayMode(contact : contact)));
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
        ),
      floatingActionButton: _floatingActionButton(),
    );
  }
  Widget _floatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child:  FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ],
    );
  }
}

class TodayMode extends StatelessWidget {
  late Contact contact;
  TodayMode({required this.contact});

  Future ToDB(DateTime startTime, DateTime finishTime, double workTime) async {
    //連結到Mysql資料庫
    MySqlConnection conn = await MySqlConnection.connect(ConnectionSettings(
        user: "root",
        password: "ZSP95142",
        host: "10.0.2.2",
        port: 3306,
        db: "fish"));
    print('connection success!!');
    //await conn.query('CREATE TABLE `timeRecord`
    // (`name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
    // `startTime` timestamp,`finishTime` timestamp,
    // `workTime` double,
    // FOREIGN KEY(`name`) REFERENCES users(`name`))');
    //insert data into db
    print(this.contact.name);
    String name = contact.name;
    Results affectedRows =
    await conn.query('insert into fish.timerecord('
        'name, startTime, finishTime, workTime) values("$name", "$startTime", "$finishTime", "$workTime")');
    if(affectedRows.isNotEmpty)
      print('success');
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.now().add(Duration(
        minutes: 30 - DateTime.now().minute % 30,
        seconds: -DateTime.now().second,
        milliseconds: -DateTime.now().millisecond));
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
                      ToDB(startTime, finishTime, workTime);
                      Time temp = Time(
                          name:contact.name,
                          startTime: startTime,
                          finishTime: finishTime,
                          workTime: workTime
                      );
                      TDB.storeSplitTimeUsingDB(temp);
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
  late Contact contact;
  OtherDayMode({required this.contact});
  ToDB(DateTime startTime, DateTime finishTime, double workTime) async {
    String name = "kobe";
    //連結到Mysql資料庫
    final conn = await MySqlConnection.connect(ConnectionSettings(
        user: "root",
        password: "ZSP95142",
        host: "10.0.2.2",
        port: 3306,
        db: "fish"));
    print('connection success!!');
    print(this.contact.name);
    String name2 = contact.name;
    Results affectedRows =
    await conn.query('insert into fish.timerecord(name, startTime, finishTime, workTime) values("$name2", "$startTime", "$finishTime", "$workTime")');
    if(affectedRows.isNotEmpty)
      print('success');
    //insert data into db
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.now().add(Duration(
        minutes: 30 - DateTime.now().minute % 30,
        seconds: -DateTime.now().second,
        milliseconds: -DateTime.now().millisecond));
    DateTime finishTime = DateTime.now();
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
                    finishTime = data;
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
                      print(finishTime);
                      totalTime = finishTime.difference(startTime).inMinutes;
                      workTime = totalTime / 60;
                      ToDB(startTime, finishTime, workTime);
                      Time temp = Time(
                          name:contact.name,
                          startTime: startTime,
                          finishTime: finishTime,
                          workTime: workTime
                      );
                      TDB.storeSplitTimeUsingDB(temp);

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
