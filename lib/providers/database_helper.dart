//src :https://stackoverflow.com/questions/54097326/how-to-do-a-database-insert-with-sqflite-in-flutter/54097327#54097327

import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

class DatabaseHelper {

  static final _databaseName = "Todo_list_database.db";
  static final _databaseVersion = 1;

  static final table = 'todos';

  static final column_id = 'id';
  static final column_title = 'title';
  static final column_isCompleted = 'isComplete';
  static final column_date = 'date';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    //await db.execute("DROP TABLE IF EXISTS todos");
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    //_database.execute("DROP TABLE IF EXISTS todos");
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $column_id TEXT PRIMARY KEY,
            $column_title TEXT NOT NULL,
            $column_isCompleted INTEGER NOT NULL,
            $column_date TEXT NOT NULL
          )
          ''');

    // // prepopulate a few rows (consider using a transaction)
    // await db.rawInsert('INSERT INTO $table ($columnName, $columnAge) VALUES("Bob", 23)');
    // await db.rawInsert('INSERT INTO $table ($columnName, $columnAge) VALUES("Mary", 32)');
    // await db.rawInsert('INSERT INTO $table ($columnName, $columnAge) VALUES("Susan", 12)');
  }
}