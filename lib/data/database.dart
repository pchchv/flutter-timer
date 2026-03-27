import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

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
}