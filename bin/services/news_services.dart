import '../models/news_model.dart';
import '../utils/list_extension.dart';
import 'generic_service.dart';

class NewsService implements GenericService<NewsModel> {
  final List<NewsModel> _fakeDb = [];

  @override
  Future<bool> delete(int value) async {
    _fakeDb.removeWhere((element) => element.id == value);
    return true;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return _fakeDb;
  }

  @override
  Future<NewsModel> findOne(int id) async {
    return _fakeDb.firstWhere((element) => element.id == id);
  }

  @override
  Future<bool> save(NewsModel value) async {
    NewsModel? news =
        _fakeDb.firstWhereOrNull((element) => element.id == value.id);
    if (news == null) {
      _fakeDb.add(value);
    } else {
      var index = _fakeDb.indexOf(news);
      _fakeDb[index] = value;
    }
    return true;
  }
}
