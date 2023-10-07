import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

import '../model/todo.dart';

class DatabaseHandler {
  static DatabaseHandler? _databaseHandler;
  static Database? _database;
  final todo = 'todo';
  Map table = {
    'tableName': 'todo',
    'colId': 'id',
    'colTitle': 'title',
    'colDescription': 'description',
    'colDate': 'date'
  };

  DatabaseHandler._createInstance();

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  factory DatabaseHandler() {
    _databaseHandler ??= DatabaseHandler._createInstance();
    return _databaseHandler!;
  }

  Future<Database> initDB() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentsDir.path, "databases", "$todo.db");
    final database = await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
    return database;
  }

  // This creates tables in our database.
  Future<void> _onCreate(Database database, int version) async {
    final db = database;
    await db.execute(""" CREATE TABLE IF NOT EXISTS todo(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date TEXT
          )
 """);
  }

  // Fetch Operation: Get all data from database
  Future<List<Map<String, dynamic>>> selectAll(String table) async {
    final db = await database;
    return db.query(table);
    //return db.rawQuery("SELECT * FROM $todo");
  }

  // Insert Operation: Insert new record to database
  Future<int> insertTodo(Todo todo) async {
    Database db = await database;
    var result = await db.insert(table['tableName'], todo.toMap());
    return result;
  }

  // Update Operation: Update record in the database
  Future<int> updateTodo(Todo todo) async {
    var db = await database;
    var result = await db.update(table['tableName'], todo.toMap(),
        where: '${table['colId']} = ?', whereArgs: [todo.id]);
    return result;
  }

  // Delete Operation: Delete record from database
  Future<int> deleteTodo(int id) async {
    var db = await database;
    int result =
        await db.delete(table['tableName'], where: 'id = ?', whereArgs: [id]);
    return result;
  }
}
