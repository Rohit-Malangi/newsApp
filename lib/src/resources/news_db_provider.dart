import 'dart:io';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache{
  late Database db;

  NewsDbProvider() {
    init();
  }

  init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ITEMS2.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newdb, int version) {
      newdb.execute("""
        CREATE TABLE ITEMS2 (
          id INTEGER PRIMARY KEY,
          deleted INTEGER,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          dead INTEGER,
          parent INTEGER,
          kids BLOB,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendant INTEGER
        )
      """);
    });
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    final map = await db
        .query("ITEMS2", columns: null, where: 'id = ?', whereArgs: [id]);
    if (map.isNotEmpty) {
      return ItemModel.fromDb(map.first);
    }
    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert('ITEMS2', item.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  
  @override
  Future<List<int>> fetchTopIds() {
    throw UnimplementedError();
  }
}