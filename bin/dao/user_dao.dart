import 'package:mysql1/mysql1.dart';

import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DbConfiguration _dbConfiguration;

  UserDAO(this._dbConfiguration);
  @override
  Future<bool> create(UserModel value) async {
    var result = await _executeQuery(
        'INSERT INTO usuarios (nome,email, password) VALUES (?,?,?)',
        [value.name, value.email, value.password]);

    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _executeQuery('DELETE from usuarios where id = ?', [id]);

    return result.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    Results result = await _executeQuery('SELECT * FROM usuarios');
    return (result).map((e) => UserModel.fromMap(e.fields)).toList();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    var result = _executeQuery('SELECT * FROM usuarios where id = ?', [id]);

    return result.affectedRows > 0
        ? UserModel.fromMap(result.first.fields)
        : null;
  }

  @override
  Future<bool> update(UserModel value) async {
    var result = await _executeQuery(
        'UPDATE usuarios set nome = ?, password = ? where id = ?',
        [value.name, value.password, value.id]);

    return result.affectedRows > 0;
  }

  Future<UserModel?> findByEmail(String email) async {
    var result =
        await _executeQuery('select * from usuarios where email = ?', [email]);

    return result.isNotEmpty ? UserModel.fromEmail(result.first.fields) : null;
  }

  _executeQuery(String sql, [List? params]) async {
    var connection = await _dbConfiguration.connection;
    return await connection.query(sql, params);
  }
}
