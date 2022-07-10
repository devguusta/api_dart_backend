import '../models/news_model.dart';
import '../utils/list_extension.dart';
import 'generic_service.dart';

class NewsService implements GenericService<NewsModel> {
  final List<NewsModel> _fakeDb = [];

  @override
  bool delete(int value) {
    _fakeDb.removeWhere((element) => element.id == value);
    return true;
  }

  @override
  List<NewsModel> findAll() {
    return _fakeDb;
  }

  @override
  NewsModel findOne(int id) {
    return _fakeDb.firstWhere((element) => element.id == id);
  }

  @override
  bool save(NewsModel value) {
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
