import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/networking/data_state.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/authentication/authentication.dart';
import 'package:lettutor/data/data_source/remote/authentication/email/email_auth_api.dart';
import 'package:lettutor/domain/mapper/user_mapper.dart';
import 'package:lettutor/domain/models/user.dart';
import 'package:lettutor/domain/repositories/authentication_repo.dart';

@injectable
class AuthUseCase {
  final AuthenticationRepository repository;

  final AuthenticationApi emailAuthApi;

  AuthUseCase(this.repository, @Named("EmailAuthApi") this.emailAuthApi);

  Future<Either<User, String>> signInEmail(
      String email, String password) async {
    return (await repository.login(email, password)).either(
      (left) => UserMapper.fromEntity(left),
      (right) => right,
    );
  }

  Future<Either<User, String>> refreshToken(
      {required String refreshToken, required int timezone}) async {
    return (await repository.refreshToken(
            refreshToken: refreshToken, timezone: timezone))
        .either(
      (left) => UserMapper.fromEntity(left.user),
      (right) => right,
    );
  }

  Future<bool> logout() async {
    return (await repository.logout());
  }

  Future<Either<User, String>> signUpEmail(
    String email,
    String password,
  ) async {
    return (await repository.register(email, password)).either(
      (left) => UserMapper.fromEntity(left),
      (right) {
        log(right);
        return right;
      },
    );
  }

  Future<String> forgetPassword(String email) async {
    return (await repository.forgetPassword(email));
  }

  Future<Either<String, String>> changePassword(
      String password, String newPassword) async {
    final response = await getStateOf<Map<String, dynamic>>(
      request: () => (emailAuthApi as EmailAuthApi).changePassword(body: {
        "password": password,
        "newPassword": newPassword,
      }),
    );

    if (response is DataSuccess) {
      return Left(response.data?["message"]);
    }
    return Right(response.dioException?.message ?? "");
  }
}
