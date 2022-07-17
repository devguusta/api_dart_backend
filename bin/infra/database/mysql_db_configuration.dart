import 'package:mysql1/mysql1.dart';

import '../../utils/custom_env.dart';
import 'db_configuration.dart';

class MySqlDBConfiguration implements DbConfiguration {
  MySqlConnection? _connection;
  @override
  // TODO: implement connection
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();

    if (_connection == null) {
      throw Exception('[ERROR/DB -> Failed to Create Connection');
    }
    return _connection!;
  }

  @override
  Future<MySqlConnection> createConnection() async {
    var settings = ConnectionSettings(
        host: await CustomEnv.get<String>(key: 'db_host'),
        port: await CustomEnv.get<int>(key: 'db_port'),
        user: await CustomEnv.get<String>(key: 'db_user'),
        password: await CustomEnv.get<String>(key: 'db_pass'),
        db: await CustomEnv.get<String>(key: 'db_schema'));
    return await MySqlConnection.connect(settings);
  }
}
