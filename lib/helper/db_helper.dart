import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;


class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'todo.db'), version: 1,
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE remaining_todo (id TEXT PRIMARY KEY, todo TEXT);CREATE TABLE completed_todo (id TEXT PRIMARY KEY, todo TEXT);");
    });
  }

  static Future<void> save(String table, Map<String, Object> data) async {
    final dbClient = await DBHelper.database();
    await dbClient.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(String table, String id) async {
     final dbClient = await DBHelper.database();
     await dbClient.delete(table, where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final dbClient = await DBHelper.database();
    return dbClient.query(table);
  }
}
