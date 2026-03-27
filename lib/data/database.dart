import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_timer/model/task.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database; // Nullable for lazy loading

  Future<Database> _initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'xtimeros.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Task (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            color INTEGER,
            title TEXT,
            hours INTEGER,
            minutes INTEGER,
            seconds INTEGER
          )
        ''');
      },
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb();
    return _database!;
  }

  Future<List<Task>> getAll() async {
    final dbClient = await database;
    final List<Map<String, dynamic>> query = await dbClient.query('Task');

    List<Task> tasks = query.isNotEmpty 
        ? query.map((t) => Task.fromMap(t)).toList() 
        : [];

    return tasks;
  }
}