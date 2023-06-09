import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';

import '../models/item_model.dart';

class Repository {
  final apiProvider = NewsApiProvider();
  final dbProvider = NewsDbProvider();

  Future<List<int>> fetchTopIds() async => await apiProvider.fetchTopIds();

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    if(item != null) return item;
    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);
    return item;
  }

}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}