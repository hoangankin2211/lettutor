import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/entities/response/auth_response.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/data/entities/user_info_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@injectable
@RestApi()
abstract class UserService {
  static const String branch = "/user";
  static const String info = "/info";
  static const String history = "/history";

  @factoryMethod
  factory UserService(Dio dio) = _UserService;

  @GET(branch + info)
  Future<HttpResponse<UserInfoResponse>> getUserInfo();

  @PUT(branch + info)
  Future<HttpResponse<UserEntity>> updateUserInfo();

  @GET(history)
  Future<HttpResponse> getHistory({@Query("page") required int page});
}
