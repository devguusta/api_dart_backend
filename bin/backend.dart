import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/dependency_injector.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_impl.dart';
import 'services/news_services.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final DependencyInjector _di = DependencyInjector();

  _di.register<SecurityService>(
    () => SecurityServiceImpl(),
    isSingleton: true,
  );

  SecurityService _securityService = _di.get<SecurityService>();
  var cascadeHandler = Cascade()
      .add(LoginApi(_securityService).getHandler())
      .add(BlogApi(NewsService()).getHandler(
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
