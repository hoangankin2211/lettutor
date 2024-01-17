import 'package:injectable/injectable.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lettutor/core/logger/custom_logger.dart';

@singleton
class FacebookOAuthService {
  late final FacebookAuth _facebookAuth;

  FacebookOAuthService() {
    _facebookAuth = FacebookAuth.instance;
  }

  Future<AccessToken> handleLogin() async {
    try {
      final LoginResult result = await _facebookAuth
          .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        // you are logged
        return result.accessToken!;
      } else {
        throw Exception(result.message ?? 'Facebook login failed');
      }
    } catch (e) {
      logger.d("message: ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
