//src :https://stackoverflow.com/questions/54097326/how-to-do-a-database-insert-with-sqflite-in-flutter/54097327#54097327

import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:intl/intl.dart';

class DatabaseHelper {
  final newFormat = DateFormat("MM-dd-yy");

  static final _databaseName = "Todo_list_database.db";
  static final _databaseVersion = 1;

  static final table = 'todos';

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnIsCompleted = 'isComplete';
  static final columnDate = 'date';

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
            $columnId TEXT PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnIsCompleted INTEGER NOT NULL,
            $columnDate TEXT NOT NULL
          )
          ''');

    // // prepopulate a few rows (consider using a transaction)
    await db.rawInsert('INSERT INTO $table VALUES("0", "Example Task", 0, "${newFormat.format(DateTime.now())}")');
    await db.rawInsert('INSERT INTO $table VALUES("1", "Swipe left to delete", 1, "${newFormat.format(DateTime.now())}")');
    await db.rawInsert('INSERT INTO $table VALUES("2", "Select checkbox to complete task", 0, "${newFormat.format(DateTime.now())}")');
  }
}