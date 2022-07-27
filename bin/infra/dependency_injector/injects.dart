import '../../apis/blog_api.dart';
import '../../apis/login_api.dart';
import '../../apis/user_api.dart';
import '../../dao/user_dao.dart';
import '../../models/news_model.dart';
import '../../services/generic_service.dart';
import '../../services/login_service.dart';
import '../../services/news_services.dart';
import '../../services/user_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_service.dart';
import '../security/security_service_impl.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DbConfiguration>(() => MySqlDBConfiguration());

    di.register<SecurityService>(() => SecurityServiceImpl());

    di.register<GenericService<NewsModel>>(() => NewsService());

    di.register<BlogApi>(() => BlogApi(di<GenericService<NewsModel>>()));

    di.register<UserDAO>(() => UserDAO(di.get<DbConfiguration>()));

    di.register<UserService>(() => UserService(di.get<UserDAO>()));

    di.register<UserApi>(() => UserApi(di.get<UserService>()));
    di.register<LoginService>(() => LoginService(di.get<UserService>()));

    di.register<LoginApi>(
        () => LoginApi(di<SecurityService>(), di.get<LoginService>()));

    return di;
  }
}
