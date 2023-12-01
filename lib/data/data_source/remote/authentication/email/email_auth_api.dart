import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/entities/response/auth_response.dart';
import 'package:retrofit/retrofit.dart';

import '../authentication.dart';

part 'email_auth_api.g.dart';

@Named("EmailAuthApi")
@Injectable(as: AuthenticationApi)
@RestApi()
abstract class EmailAuthApi implements AuthenticationApi {
  static const String branch = "/auth";
  static const String loginApi = "$branch/login";
  static const String refreshTokenApi = "$branch/refresh-token";
  static const String registerApi = "$branch/register";
  static const String logoutApi = "$branch/logout";
  static const String changePasswordApi = "$branch/change-password";

  @factoryMethod
  factory EmailAuthApi(Dio dio) = _EmailAuthApi;

  @override
  @POST(loginApi)
  Future<HttpResponse<AuthResponse>> signIn(
      {@Body() required Map<String, dynamic> body});

  @override
  @POST(logoutApi)
  Future<HttpResponse<dynamic>> signOut();

  @override
  @POST(registerApi)
  Future<HttpResponse<AuthResponse>> signUp(
      {@Body() required Map<String, dynamic> body});

  @override
  @POST(refreshTokenApi)
  Future<HttpResponse<AuthResponse>> refreshToken(
      {@Body() required Map<String, dynamic> body});

  @POST(changePasswordApi)
  Future<HttpResponse<Map<String, String>>> changePassword(
      {@Body() required Map<String, dynamic> body});

  @override
  @POST("user/forgotPassword")
  Future<HttpResponse> forgetPassword({required Map<String, dynamic> body});
}
