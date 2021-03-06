import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>(); // similar to StreamController
  final _itemsOutput = BehaviorSubject<
      Map<int,
          Future<ItemModel>>>(); // Widgets are going to listen to this Stream
  final _itemFetcher = PublishSubject<int>();

  // Streams to retrieve data
  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Add data (Individual Id) to _items Stream
  Function(int) get fetchItem => _itemFetcher.sink.add;

  // Add Top Ids to Stream
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() {
    return _repository.clearCache();
  }

  StoriesBloc() {
    _itemFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  // Transformer for Items
  _itemsTransformer() {
    return ScanStreamTransformer(
      // Invokes every time a new element comes into the transformer
      (Map<int, Future<ItemModel>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      // Initial value [ Cache Map ]
      // Empty Map
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemFetcher.close();
  }
}
