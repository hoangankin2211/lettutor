import 'package:injectable/injectable.dart';
import 'package:lettutor/data/data_source/remote/authentication/authentication.dart';
import 'package:retrofit/dio.dart';

@Named("GoogleAuthImpl")
@Injectable(as: AuthenticationApi)
class GoogleAuthImpl implements AuthenticationApi {
  @override
  Future<HttpResponse> login({required Map<String, dynamic> body}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse> refreshToken({required Map<String, dynamic> body}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }
}
