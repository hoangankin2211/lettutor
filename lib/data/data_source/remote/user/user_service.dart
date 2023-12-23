import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
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
  static const String register = "/register";

  @factoryMethod
  factory UserService(Dio dio) = _UserService;

  @GET(branch + info)
  Future<HttpResponse<UserInfoResponse>> getUserInfo();

  @PUT(branch + info)
  Future<HttpResponse<UserInfoResponse>> updateUserInfo(
      {@Body() required Map<String, dynamic> body});

  @POST(branch + register)
  Future<HttpResponse> becomeTutor({
    @Body() required Map<String, dynamic> body,
    @Header("contentType") contentType = "multipart/form-data",
  });

  @GET(history)
  Future<HttpResponse> getHistory({@Query("page") required int page});
}
