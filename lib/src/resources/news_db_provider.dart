import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database db;

  init() async {
    // returns reference to a directory
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // path - stores the reference of actual path where we can create our database
    final path = join(documentDirectory.path, 'items.db');

    // openDatabase - opens the database that is already exists at the path
    // and if there is no database at the path then it is going to create the database for us.

    // version - its to keep track of the database. If we change our database schema
    // in future then  we can change version.

    // onCreate - called only once when database is created and when user open our
    // application for first time
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute('''
          CREATE TABLE Items
            (
             id INTEGER PRIMARY KEY,
             type TEXT,
             by TEXT,
             time INTEGER,
             text TEXT,
             parent INTEGER,
             kids BLOB,
             dead INTEGER,
             deleted INTEGER,
             url TEXT,
             score INTEGER,
             title TEXT,
             descendants INTEGER
            )
          ''');
      },
    );
  }

  fetchItem(int id) async {
    final maps = await db.query(
      'Items',
      columns: null, //['column1', 'column2']
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  addItem(ItemModel item) {
    return db.insert('Items', item.toMap());
  }
}
