import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../authentication.dart';

part 'email_auth_api.g.dart';

@Named("EmailAuthApi")
@Injectable(as: AuthenticationApi)
@RestApi()
abstract class EmailAuthApi implements AuthenticationApi {
  static const String branch = "";
  static const String loginApi = "/auth/login";
  static const String refreshTokenApi = "$branch/auth/refresh-token";
  static const String registerApi = "$branch/auth/register";
  static const String logoutApi = "$branch/auth/logout";

  @factoryMethod
  factory EmailAuthApi(Dio dio) = _EmailAuthApi;

  @override
  @POST(loginApi)
  Future<HttpResponse<dynamic>> login(
      {@Body() required Map<String, dynamic> body});

  @override
  @POST(logoutApi)
  Future<HttpResponse<dynamic>> logout();

  @override
  @POST(refreshTokenApi)
  Future<HttpResponse<dynamic>> refreshToken(
      {@Body() required Map<String, dynamic> body});
}
