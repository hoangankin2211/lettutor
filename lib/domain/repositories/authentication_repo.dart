import '../models/models.dart';

abstract class AuthenticationRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password);
  Future<void> logout();
  Future<User> getCurrentUser();
}
