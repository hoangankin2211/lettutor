import 'package:either_dart/either.dart';
import 'package:lettutor/core/utils/networking/data_state.dart';
import 'package:lettutor/data/entities/response/auth_response.dart';
import 'package:lettutor/data/entities/user_entity.dart';

import '../models/models.dart';

abstract class AuthenticationRepository {
  Future<Either<UserEntity, String>> login(String email, String password);
  Future<Either<AuthResponse, String>> refreshToken(
      {required String refreshToken, required int timezone});
  Future<Either<UserEntity, String>> register(String email, String password);
  Future<bool> logout();
  Future<User> getCurrentUser();
  Future<Either<DataFailed, DataSuccess>> forgetPassword(String email);
}
