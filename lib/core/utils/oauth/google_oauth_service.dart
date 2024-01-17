import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@singleton
class GoogleOAuthService {
  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  late final GoogleSignIn _googleSignIn;

  GoogleOAuthService() {
    _googleSignIn = GoogleSignIn(
      // Optional clientId
      // clientId: 'your-client_id.apps.googleusercontent.com',
      clientId:
          "139519089080-493pk2sa5b558989m9q9foac0400lm8f.apps.googleusercontent.com",
      scopes: scopes,
    );
  }

  Future<GoogleSignInAccount?> handleSignIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
}
