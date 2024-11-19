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
/*


class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper databaseHelper = DatabaseHelper._();

  Database? _database;
  String databaseName = 'expense.db';
  String tableName = 'expense';

  Future<Database> get database async => _database ?? await initDatabase();

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, databaseName);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
        CREATE TABLE $tableName (
          id INTEGER NOT NULL,
          title TEXT NOT NULL,
          amount TEXT NOT NULL,
          date TEXT NOT NULL,
          category TEXT NOT NULL
        )
        ''';
        db.execute(sql);
      },
    );
  }

  Future<bool> expenseExist(int id) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE id = ?
    ''';
    List<Map<String, Object?>> result = await db.rawQuery(sql, [id]);
    return result.isNotEmpty;
  }

  Future<int> addExpenseToDatabase(
      int id, String title, String date, String amount, String category) async {
    final db = await database;
    String sql = '''
    INSERT INTO $tableName(
    id, title, amount, date, category
    ) VALUES (?, ?, ?, ?, ?)
    ''';
    List args = [id, title, amount, date, category];
    return await db.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readAllExpense() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> getExpenseByCategory(String category) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE category LIKE '%$category%'
    ''';
    return await db.rawQuery(sql);
  }

  Future<int> updateExpense(int id, String title, String amount, String date,
      String category) async {
    final db = await database;
    String sql = '''
    UPDATE $tableName SET title = ?, amount = ?, date = ?, category = ? WHERE id = ?
    ''';
    List args = [title, amount, date, category, id];
    return await db.rawUpdate(sql, args);
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db.rawDelete(sql, args);
  }
}
*/