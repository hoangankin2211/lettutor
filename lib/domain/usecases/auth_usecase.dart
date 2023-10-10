import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/domain/mapper/user_mapper.dart';
import 'package:lettutor/domain/models/user.dart';
import 'package:lettutor/domain/repositories/authentication_repo.dart';

@injectable
class AuthUseCase {
  final AuthenticationRepository repository;

  AuthUseCase(this.repository);

  Future<Either<User, String>> signInEmail(
      String email, String password) async {
    return (await repository.login(email, password)).either(
      (left) => UserMapper.fromEntity(left),
      (right) => right,
    );
  }
}
