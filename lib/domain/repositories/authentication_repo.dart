import 'package:either_dart/either.dart';
import 'package:lettutor/data/entities/response/auth_response.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/ui/auth/views/widgets/forget_password/forget_password_widget.dart';

import '../models/models.dart';

abstract class AuthenticationRepository {
  Future<Either<UserEntity, String>> login(String email, String password);
  Future<Either<AuthResponse, String>> refreshToken(
      {required String refreshToken, required int timezone});
  Future<Either<UserEntity, String>> register(String email, String password);
  Future<bool> logout();
  Future<User> getCurrentUser();
  Future<String> forgetPassword(String email);
}
