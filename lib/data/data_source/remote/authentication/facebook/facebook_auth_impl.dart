import 'package:injectable/injectable.dart';
import 'package:lettutor/data/data_source/remote/authentication/authentication.dart';
import 'package:retrofit/dio.dart';

@Named("FacebookAuthImpl")
@Injectable(as: AuthenticationApi)
class FacebookAuthImpl implements AuthenticationApi {
  @override
  Future<HttpResponse> refreshToken({required Map<String, dynamic> body}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse> signIn({required Map<String, dynamic> body}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
