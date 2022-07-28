import '../dao/news_dao.dart';
import '../models/news_model.dart';
import 'generic_service.dart';

class NewsService implements GenericService<NewsModel> {
  final NewDAO _newDAO;

  NewsService(this._newDAO);

  @override
  Future<bool> delete(int value) async {
    return await _newDAO.delete(value);
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return await _newDAO.findAll();
  }

  @override
  Future<NewsModel?> findOne(int id) async {
    return await _newDAO.findOne(id);
  }

  @override
  Future<bool> save(NewsModel value) async {
    if (value.id != null) {
      return _newDAO.update(value);
    } else {
      return _newDAO.create(value);
    }
  }
}
