import 'dart:async';
import 'package:mysql1/mysql1.dart';

class timeDatabase {
  static timeDatabase _timeDatabase = new timeDatabase();
  timeDatabase();
  late MySqlConnection cnt;
  bool initDB = false;

  Future init() async{
    // Open a connection (table1 should already exist)
    cnt = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        db: 'table1',
        password: '12345678'));

    // Create a table
    await conn.query(
        'CREATE TABLE IF NOT EXISTS `table1` ( `id` int unsigned NOT NULL, `user_id` int unsigned NOT NULL, `start` datetime NOT NULL, `end` datetime NOT NULL, PRIMARY KEY (`id`) )');
    initDB = true;
  }

  static timeDatabase get(){
    return _timeDatabase;
  }
  Future _getDB() async{
    if(!initDB) await init();
    return cnt;
  }

  Future<EventObject> gettTimeUsingDB() async {

      var db = await _timeDatabase._getDB();
      Results contact = await db.query('SELECT`user_id`,(HOUR(`start`) * 60 + MINUTE(`start`)) DIV 30 as `start_index`,(HOUR(`end`) * 60 + MINUTE(`end`)) DIV 30 as `end_index`FROM`table1`');

  }

  Future<EventObject> gettTotalUsingDB() async {
    var db = await _timeDatabase._getDB();
    Results contact = await db.query('SELECT  `sq`.*,(`sq`.`end_index` - `sq`.`start_index` + 1) as `count`FROM (SELECT`user_id`,(HOUR(`start`) * 60 + MINUTE(`start`)) DIV 30 as `start_index`,(HOUR(`end`) * 60 + MINUTE(`end`)) DIV 30 as `end_index`FROM`table1`) AS `sq`');

  }
}

