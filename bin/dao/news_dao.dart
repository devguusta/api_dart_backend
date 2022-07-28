import '../infra/database/db_configuration.dart';
import '../models/news_model.dart';
import 'dao.dart';

class NewDAO implements DAO<NewsModel> {
  final DbConfiguration _dbConfiguration;
  NewDAO(this._dbConfiguration);

  @override
  Future<bool> create(NewsModel value) async {
    var result = await _dbConfiguration.execQuery(
      'insert into noticias (titulo, descricao, id_usuario) values (?, ?, ?)',
      [value.title, value.description, value.userId],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration
        .execQuery('DELETE from noticias where id = ?', [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM noticias');
    return result
        .map((r) => NewsModel.fromMap(r.fields))
        .toList()
        .cast<NewsModel>();
  }

  @override
  Future<NewsModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM noticias where id = ?', [id]);
    return result.affectedRows == 0
        ? null
        : NewsModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(NewsModel value) async {
    var result = await _dbConfiguration.execQuery(
      'update noticias set titulo = ?, descricao = ? where id = ?',
      [value.title, value.description, value.id],
    );
    return result.affectedRows > 0;
  }
}
