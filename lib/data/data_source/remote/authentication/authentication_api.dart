import 'package:retrofit/retrofit.dart';

import '../../../entities/response/auth_response.dart';

abstract class AuthenticationApi {
  Future<HttpResponse<AuthResponse>> signIn(
      {@Body() required Map<String, dynamic> body});

  Future<HttpResponse<dynamic>> signOut();

  Future<HttpResponse<AuthResponse>> signUp(
      {@Body() required Map<String, dynamic> body});

  Future<HttpResponse<AuthResponse>> refreshToken(
      {@Body() required Map<String, dynamic> body});

  Future<HttpResponse> forgetPassword(
      {@Body() required Map<String, dynamic> body});
}
