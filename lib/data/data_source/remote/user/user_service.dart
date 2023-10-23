import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@injectable
@RestApi()
abstract class UserService {
  static const String history = "/history";

  @factoryMethod
  factory UserService(Dio dio) = _UserService;

  @GET(history)
  Future<HttpResponse> getHistory({@Query("page") required int page});
}
