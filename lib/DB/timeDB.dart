import 'dart:async';
import 'package:fish/utils/Constants.dart';
import 'package:fish/utils/Contact.dart';
import 'package:fish/utils/MyLib.dart';
import 'package:mysql1/mysql1.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
class Time{
  late String name;
  late DateTime startTime;
  late DateTime finishTime;
  late double workTime;
  Time({
    required this.name,
    required this.startTime,
    required this.finishTime,
    required this.workTime
  });
  static Time fromMap(Map map){
    return new Time(
      name: map[TimeDataTable.name],
      startTime:map[TimeDataTable.startTime],
      finishTime:map[TimeDataTable.endTime],
      workTime:map[TimeDataTable.workTime],
    );
  }
}
class splitTimeData{
  late String name;//store
  late String day;//store
  late int start;
  late int end;
  List<int> split =List.filled(48, 0); //lin 你要用的東西在這(48格LIST)
  late String storeForm; //省空間, store
  splitTimeData({
    required this.name,
    required this.day,
    required this.start,
    required this.end,
  });
  List<int> splitTheTime(){
    for(int i = this.start ; i <= this.end ; i++)
      this.split[i] = 1;
    return this.split;
  }
  static List<int> getTheList(String target){
    List<int> output = List.filled(48, 0);
    int posi = 0;
    print(target);
    for(String i in target.characters){
      if(i.compareTo('1') == 0 ){
        output[posi] = 1;
        posi++;
      } else if (i.compareTo('0') == 0) {
        output[posi] = 0;
        posi++;
      }
    }
    //print(output);
    return output;
  }
  String storeStringFromList(){
    this.storeForm = split.toString();
    return this.storeForm;
  }
  static splitTimeData fromMap(Map map){
    String n=map['name'];
    String d=map['day'];
    String s=map['storeform'];
    List<int> num = getTheList(s);
    int start=0, end=0;
    int status = 0;
    for(int i = 0; i< 48 ; i++){
      if(num[i]==1 && status == 0){
        start = i;
        status = 1;
      }else if(num[i]==0&&status==1){
        end = i;
        break;
      }
    }
    return new splitTimeData (
      name: n,
      day:d,
      start : start,
      end:end,
    );
  }
}
class timeDatabase {
  static timeDatabase _timeDatabase = new timeDatabase();
  timeDatabase();
  late MySqlConnection cntdb;
  bool initDB = false;

  Future init() async{
    // Open a connection (table1 should already exist)
    cntdb = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'fish',
        password: 'ZSP95142'));

    // Create a table
    await cntdb.query(
        'CREATE TABLE `splittime` ( '
            '`id` int not null auto_increment,'
            '`name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,'
            '`day` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,'
            '`storeform` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,'
            ' PRIMARY KEY (`id`) )');
    initDB = true;
  }

  static timeDatabase get(){
    return _timeDatabase;
  }
  Future _getDB() async{
    if(!initDB) await init();
    return cntdb;
  }
  Future <List<Time>> usersGettime() async{
    try{
      var db = await _timeDatabase._getDB();
      Results contact = await db.query('SELECT * FROM fish.timerecord');
      List<Time>  contacts = <Time>[];
      for(var i in contact){
        contacts.add(Time.fromMap(i.fields));
      }
      return contacts;
    }catch(e){
      print('error');
      print(e.toString());
      return [];
    }
  }

  Future storeSplitTimeUsingDB(Time t) async {
    splitTimeData FinalTimeData;
    int startTimeExceed = 0, endTimeExceed = 0;
    if(t.startTime.minute >=30)
      startTimeExceed = 1;
    if(t.finishTime.minute >= 30)
      endTimeExceed = 1;
    splitTimeData temp = splitTimeData(
      name: t.name,
      day : t.startTime.toString().substring(0, 10),
      start: (t.startTime.hour *2) + startTimeExceed,
      end: (t.finishTime.hour *2) + endTimeExceed,
    );
    print(temp);
    temp.split = temp.splitTheTime();
    temp.storeForm = temp.storeStringFromList();
    FinalTimeData = temp;
    saveSplitTimeUsingDB(FinalTimeData);

  }
  Future saveSplitTimeUsingDB(splitTimeData target)async{
    var db = await _timeDatabase._getDB();
    print(target.storeForm);
    Results affectRows =
    await db.query(
        'insert into fish.splittime (name, day, storeform) values(?,?,?)',
        [target.name, target.day, target.storeForm]
    );
    if(affectRows.isEmpty)
      print('success');
    else{
      print('fail');
    }
    print('finish');
  }

}

class split{
  late String name;
  late DateTime date;
  late String storeform;
  split({
    required this.name,
    required this.date,
    required this.storeform,
  });
}

class split_time_table{
  static split_time_table _split_time_table = new split_time_table();
  split_time_table();
  late MySqlConnection cntdb;
  bool initDB = false;

  Future init() async{
    // Open a connection (table1 should already exist)
    cntdb = await MySqlConnection.connect(ConnectionSettings(
        host: '10.0.2.2',
        port: 3306,
        user: 'root',
        db: 'fish',
        password: 'ZSP95142'));
      /*await cntdb.query(
          'CREATE TABLE `splittime` ( '
              '`id` int not null auto_increment,'
              '`name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,'
              '`day` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,'
              '`storeform` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,'
              ' PRIMARY KEY (`id`) )');


       */
      await cntdb.query('SELECT * FROM fish.splittime');
    initDB = true;
  }

  static split_time_table get(){
    return _split_time_table;
  }
  Future _getDB() async{
    if(!initDB) await init();
    return cntdb;
  }
  Future <List<int>> day_work_table(String name, DateTime d, int c_day) async{
    List<int> table=[
      0,0,0,0,0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,0,0,0,0,
      0,0,0,0,0,0,0,0,0,0,0,0];
    try{
      var db = await _split_time_table._getDB();
      String date = d.toString().substring(0, 10);
      if(c_day < 10) {
        date = date.replaceRange(8, 9, '0');
        date = date.replaceRange(9, 10, c_day.toString());
      }
      else
        date = date.replaceRange(8, 10, c_day.toString());
      Results contact = await db.query('SELECT * FROM fish.splittime where (day="$date") and (name="$name") ');
      List<splitTimeData>  contacts = <splitTimeData> [];
      int num = 0 ;
      for(var i in contact){
        contacts.add(splitTimeData.fromMap(i.fields));
        num++;
      }
        for(var a in contacts) {
          for (int i = a.start; i < a.end; i++)
            table[i] = 1;
        }
        cntdb.close();
      return table;//contacts;
    }catch(e){
      print('error');
      print(e.toString());
      return [];
    }
  }
}