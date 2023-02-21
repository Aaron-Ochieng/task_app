import 'package:sqflite/sqflite.dart';
import 'package:theme_changer/models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}tasks.db';
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          // ignore: avoid_print
          print('Creating new one');
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING , note TEXT ,date STRING,"
            "startTime STRING, endTime STRING,repeat STRING,"
            "color INTEGER , remind INTEGER , isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    // ignore: avoid_print
    print('query function called');
    return await _db!.query(_tableName);
  }

  static Future<void> delete(Task task) async {
    await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static Future<void> update(int id) async {
    await _db!.rawUpdate('''
          UPDATE tasks
          SET isCompleted = ?
          WHERE id = ?
          ''', [1, id]);
  }
}
