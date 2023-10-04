import 'package:retrofit/retrofit.dart';

abstract class AuthenticationApi {
  Future<HttpResponse<dynamic>> signIn(
      {@Body() required Map<String, dynamic> body});

  Future<HttpResponse<dynamic>> signOut();

  Future<HttpResponse<dynamic>> refreshToken(
      {@Body() required Map<String, dynamic> body});
}
