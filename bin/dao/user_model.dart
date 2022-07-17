import 'package:mysql1/mysql1.dart';

import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DbConfiguration _dbConfiguration;

  UserDAO(this._dbConfiguration);
  @override
  Future create(UserModel value) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future delete(int id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> findAll() async {
    final String SQL = 'SELECT * FROM usuarios';
    var connection = await _dbConfiguration.connection;
    Results result = await connection.query(SQL);
    return (result).map((e) => UserModel.fromMap(e.fields)).toList();
  }

  @override
  Future<UserModel> findOne(int id) async {
    final String SQL = 'SELECT * FROM usuarios where id = ?';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(SQL, [id]);
    if (result.length <= 0) {
      throw Exception('[ERROR/DB] -> findOne for id $id, Not found');
    }

    return UserModel.fromMap(result.first.fields);
  }

  @override
  Future update(UserModel value) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
