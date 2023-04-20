import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
  }
  void Function(int) get addItem => _itemsFetcher.sink.add;
  ValueStream<Map<int, Future<ItemModel>>> get itemStream => _itemsOutput.stream;

  Stream<List<int>> get topIds => _topIds.stream;
  void fetchIds() async {
    _topIds.sink.add(await _repository.fetchTopIds());
  }

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>> _itemTransformer() {
    return ScanStreamTransformer(
      (cache, int value, index) {
        cache[value] = _repository.fetchItem(value);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  void dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
