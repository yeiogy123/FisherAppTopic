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
  /*List<int> getTheList(){
    return json.decode(storeForm);
  }*/
  static List<int> getTheList(String target){
    return json.decode(target) as List<int>;
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
    print('num = ');
    print(num);
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
        password: 'Lin15051780!'));

    // Create a table
    /*await cntdb.query(
        'CREATE TABLE `splittime` ( '
            '`id` int not null auto_increment,'
            '`name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,'
            '`day` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,'
            '`storeform` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,'
            ' PRIMARY KEY (`id`) )');

     */

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
      for(int i=0 ; i< contact.toList().length; i++){
        contacts.add(Time.fromMap(contact.toList().elementAt(i).fields));
      }
      return contacts;
    }catch(e){
      print('error');
      print(e.toString());
      return [];
    }
  }

  Future storeSplitTimeUsingDB(Time t) async {
    var db = await _timeDatabase._getDB();
    //Results contact = await db.query('SELECT`user_id`,(HOUR(`start`) * 60 + MINUTE(`start`)) DIV 30 as `start_index`,(HOUR(`end`) * 60 + MINUTE(`end`)) DIV 30 as `end_index`FROM`table1`');
    /*Results Data = await db.quert(
       'SELECT * FROM fish.timeRecord where name = ?', t.name
     );
     int flag = 0;
     List<Time> TimeData = <Time>[];
     for( int i = 0 ; i < Data.toList().length ; i++ ){
       TimeData.add(Time.fromMap(Data.toList().elementAt(i).fields));
     }
     flag = 1;

      */
    splitTimeData FinalTimeData;
    int startTimeExceed = 0, endTimeExceed = 0;
    if(t.startTime.minute > 30)
      startTimeExceed = 1;
    if(t.finishTime.minute > 30)
      endTimeExceed = 1;
    splitTimeData temp = splitTimeData(
      name: t.name,
      day : t.startTime.toString().substring(0, 10),
      start: t.startTime.hour <<1 + startTimeExceed,
      end: t.finishTime.hour << 1 + endTimeExceed,
    );
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

/*Future<EventObject> gettTimeUsingDB() async {
    var db = await _timeDatabase._getDB();
    //Results contact = await db.query('SELECT  `sq`.*,(`sq`.`end_index` - `sq`.`start_index` + 1) as `count`FROM (SELECT`user_id`,(HOUR(`start`) * 60 + MINUTE(`start`)) DIV 30 as `start_index`,(HOUR(`end`) * 60 + MINUTE(`end`)) DIV 30 as `end_index`FROM`table1`) AS `sq`');

  }

   */
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
        password: 'Lin15051780!'));

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
      Results contact = await db.query('SELECT * FROM fish.splittime');
      List<splitTimeData>  contacts = <splitTimeData> [];
      //print(contact);
      print('hi');
      print(contact.toList().length);
      for(int i=0 ; i< contact.toList().length; i++){
        print(splitTimeData.fromMap(contact.toList().elementAt(i).fields));
        //contacts.add(splitTimeData.fromMap(contact.toList().elementAt(i).fields));
        //print(contacts[i]);
      }
      /*for(int i =0; contacts[i].name!=null ;i++) {
        print(contacts[i]);
        /*if(name==contacts[i].name && d.month == contacts[i].day) {
          List<int> r = contacts[i].storeform;
          for (int j = 0; j < 48; j++) {
            if(r[j]=='1'){
              table[j] = 1;
            }
          }
        }*/
      }*/
      return table;//contacts;
    }catch(e){
      print('error');
      print(e.toString());
      return [];
    }
  }
}
