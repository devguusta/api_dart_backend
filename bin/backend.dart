import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'dao/user_model.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_configuration.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final _di = Injects.initialize();
  var connection = await _di.get<DbConfiguration>().connection;

  UserDAO _userDAO = UserDAO(_di<DbConfiguration>());
  print(await _userDAO.findAll());
  await _userDAO.findOne(2);

  var cascadeHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<BlogApi>().getHandler(
            isSecurity: true,
          ))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middlerware)
      .addHandler(cascadeHandler);
  await CustomServer().initialize(
      handler: handler,
      address: await CustomEnv.get<String>(key: 'server_address'),
      port: await CustomEnv.get<int>(key: 'server_port'));
}
