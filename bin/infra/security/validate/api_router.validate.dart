class ApiRouterValidate {
  final List<String> _routes = [];

  ApiRouterValidate add(String router) {
    _routes.add(router);
    return this;
  }

  bool isPublic(String router) {
    return _routes.contains(router);
  }
}
