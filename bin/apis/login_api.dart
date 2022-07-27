import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';
import '../services/login_service.dart';
import '../to/auth_to.dart';
import 'api.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  final LoginService _loginService;

  LoginApi(this._securityService, this._loginService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/login', (Request req) async {
      var body = await req.readAsString();
      var authTo = AuthTo.fromRequest(body);
      var userId = await _loginService.authenticate(authTo);
      if (userId.isNegative) {
        return Response(401);
      } else {
        var jwt = await _securityService.generateJWT(userId.toString());
        return Response.ok(jsonEncode({'token': jwt}));
      }
    });
    return createHandler(router: router, middlewares: middlewares);
  }
}
