import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  Middleware get middlerware {
    return createMiddleware(responseHandler: (Response res) {
      return res.change(headers: {'contet-type': 'application/json'});
    });
  }
}
