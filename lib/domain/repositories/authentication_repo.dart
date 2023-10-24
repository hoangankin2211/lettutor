import 'package:either_dart/either.dart';
import 'package:lettutor/data/entities/user_entity.dart';

import '../models/models.dart';

abstract class AuthenticationRepository {
  Future<Either<UserEntity, String>> login(String email, String password);
  Future<Either<UserEntity, String>> register(String email, String password);
  Future<void> logout();
  Future<User> getCurrentUser();
}
