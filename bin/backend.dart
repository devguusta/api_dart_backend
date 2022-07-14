import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_impl.dart';
import 'services/news_services.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');
  SecurityService _securityService = SecurityServiceImpl();
  var cascadeHandler = Cascade()
      .add(
        (LoginApi(_securityService).handler),
      )
      .add(BlogApi(
        NewsService(),
      ).handler)
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middlerware)
      .addMiddleware(_securityService.authorization)
      .addMiddleware((_securityService.verifyJwt))
      .addHandler(cascadeHandler);
  await CustomServer().initialize(
      handler: handler,
      address: await CustomEnv.get<String>(key: 'server_address'),
      port: await CustomEnv.get<int>(key: 'server_port'));

  String teste = "84";
  teste.endsWith("4");
}
