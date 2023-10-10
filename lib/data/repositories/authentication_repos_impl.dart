// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/components/networking/interceptor/api_token_interceptor.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/authentication/authentication.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/domain/models/user.dart';

import '../../core/components/networking/data_state.dart';
import '../../domain/repositories/repositories.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi _authenticationApi;
  final AppLocalStorage _appLocalStorage;

  AuthenticationRepositoryImpl(
    @Named("EmailAuthApi") this._authenticationApi,
    this._appLocalStorage,
  );

  @override
  Future<User> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<UserEntity, String>> login(
      String email, String password) async {
    final state = await getStateOf(
      request: () async {
        return await _authenticationApi.signIn(body: {
          'email': email,
          'password': password,
        });
      },
    );

    if (state is DataSuccess) {
      await _appLocalStorage.saveString(
        accessTokenKey,
        state.data!.tokens.access.token,
      );

      return Left(state.data!.user);
    }

    return Right(state.dioException?.message ?? "Error while sign in");
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
