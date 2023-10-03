import 'package:retrofit/retrofit.dart';

abstract class AuthenticationApi {
  Future<HttpResponse<dynamic>> login(
      {@Body() required Map<String, dynamic> body});

  Future<HttpResponse<dynamic>> logout();

  Future<HttpResponse<dynamic>> refreshToken(
      {@Body() required Map<String, dynamic> body});
}
