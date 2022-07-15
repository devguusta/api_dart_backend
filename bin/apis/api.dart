import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    final DependencyInjector _di = DependencyInjector();

    SecurityService _securityService = _di.get<SecurityService>();

    middlewares ??= [];

    var pipe = Pipeline();
    // ignore: avoid_function_literals_in_foreach_calls
    middlewares.forEach((m) => pipe = pipe.addMiddleware(m));

    return pipe.addHandler(router);
  }
}
