import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "items6.db");
    db = await openDatabase(
      path,
      version: 6,
      onCreate: (Database newDb, int version) {
        newDb.execute(
          """
            CREATE TABLE Items
              (
                id INTEGER PRIMARY KEY,
                type TEXT,
                time INTEGER,
                text TEXT,
                parent INTEGER,
                kids BLOB,
                dead INTEGER,
                deleted INTEGER,
                url TEXT,
                score INTEGER,
                title TEXT,
                descendants INTEGER,
                by INTEGER
              );
              
            
          """
        );
      }
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel model) {
    return db.insert(
      "Items",
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<int>> fetchTopIds() {
    return null;
  }

  clear() {
    return db.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();