import 'package:injectable/injectable.dart';
import 'package:lettutor/data/data_source/remote/authentication/authentication.dart';
import 'package:lettutor/data/entities/response/auth_response.dart';
import 'package:retrofit/dio.dart';

@Named("GoogleAuthImpl")
@Injectable(as: AuthenticationApi)
class GoogleAuthImpl implements AuthenticationApi {
  @override
  Future<HttpResponse<AuthResponse>> refreshToken(
      {required Map<String, dynamic> body}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<AuthResponse>> signIn(
      {required Map<String, dynamic> body}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<dynamic>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
