import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modal/modal.dart';

class DbHelper {
  DbHelper._();

  final String databaseName = "expanseDatabase.db";
  final String tableName = "expanseDatabase";

  static DbHelper dbHelper = DbHelper._();

  Database? _database;

  //Create
  Future<Database?> get database async => _database ?? await createDatabase();

  Future<Database?> createDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, databaseName);

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''
        CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        category TEXT NOT NULL,
        amount TEXT NOT NULL,
        date TEXT NOT NULL
        )
    ''';
        await db.execute(sql);
      },
    );
    return _database;
  }

  //insert
  Future<void> insertData(ExpanseModal expanse) async {
    Database? db = await database;
    String sql =
        '''INSERT INTO $tableName (title,category,amount,date) VALUES (?,?,?,?)
    ''';
    List args = [expanse.title, expanse.category, expanse.amount, expanse.date];
    await db!.rawInsert(sql, args);
    print('sql document added');
  }

  //Read
  Future<List<Map<String, Object?>>> readData() async {
    Database? db = await database;
    String sql = "SELECT * FROM $tableName";
    return await db!.rawQuery(sql);
  }

  // Update
  Future<void> updateSqlData(ExpanseModal expanse, int id) async {
    Database? db = await database;
    String sql = '''
    UPDATE $tableName SET id = ?,title = ? , category = ? , amount = ?, date = ? WHERE id = ?
    ''';
    List args = [expanse.title, expanse.category, expanse.amount, expanse.date];
    await db!.rawUpdate(sql, args);
  }
  // Future<void> deleteSqlData(int id) async {
  //   Database? db = await database;
  //   String sql = '''
  //   DELETE FROM $tableName WHERE id = ?
  //   ''';
  //   List args = [id];
  //   await db!.rawDelete(sql,args);
  // }
  Future<int> delete(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db!.rawDelete(sql, args);
  }
  Future<List<Map<String, Object?>>> searchByCategory(String category) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE category LIKE '%$category%'
    ''';
    return await db!.rawQuery(sql);
  }
  Future<int> deleteData(int id) async {
    Database? db = await database;
    return await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
