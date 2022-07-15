import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/news_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final GenericService<NewsModel> _service;

  BlogApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();
    router.get('/blog/noticias', (Request req) {
      List<NewsModel> news = _service.findAll();
      if (news.isEmpty) {
        return Response(201, body: "No content");
      }
      List newsMap = news.map((e) => e.toMap()).toList();
      return Response.ok(newsMap);
    });

    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) {
        return Response.badRequest(body: 'Params required');
      }
      _service.save(NewsModel.fromMap(jsonDecode(body)));
      return Response(201, body: body);
    });

    router.put('/blog/noticias', (Request req) {
      // _service.save(value);
      String? id = req.url.queryParameters['id'];
      return Response.ok('Choveu hoje');
    });

    router.delete('/blog/noticias', (Request req) {
      _service.delete(1);
      String? id = req.url.queryParameters['id'];
      return Response.ok('Choveu hoje');
    });
    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}
