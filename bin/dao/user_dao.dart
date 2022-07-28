import 'package:mysql1/mysql1.dart';

import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DbConfiguration _dbConfiguration;

  UserDAO(this._dbConfiguration);
  @override
  Future<bool> create(UserModel value) async {
    var result = await _dbConfiguration.execQuery(
        'INSERT INTO usuarios (nome,email, password) VALUES (?,?,?)',
        [value.name, value.email, value.password]);

    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration
        .execQuery('DELETE from usuarios where id = ?', [id]);

    return result.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    Results result = await _dbConfiguration.execQuery('SELECT * FROM usuarios');
    return (result).map((e) => UserModel.fromMap(e.fields)).toList();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    var result =
        _dbConfiguration.execQuery('SELECT * FROM usuarios where id = ?', [id]);

    return result.affectedRows > 0
        ? UserModel.fromMap(result.first.fields)
        : null;
  }

  @override
  Future<bool> update(UserModel value) async {
    var result = await _dbConfiguration.execQuery(
        'UPDATE usuarios set nome = ?, password = ? where id = ?',
        [value.name, value.password, value.id]);

    return result.affectedRows > 0;
  }

  Future<UserModel?> findByEmail(String email) async {
    var result = await _dbConfiguration
        .execQuery('select * from usuarios where email = ?', [email]);

    return result.isNotEmpty ? UserModel.fromEmail(result.first.fields) : null;
  }
}
