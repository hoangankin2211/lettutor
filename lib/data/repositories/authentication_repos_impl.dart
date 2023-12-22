// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/networking/interceptor/api_token_interceptor.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/authentication/authentication.dart';
import 'package:lettutor/data/entities/response/auth_response.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/domain/models/user.dart';

import '../../core/utils/networking/data_state.dart';
import '../../domain/repositories/repositories.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi _authenticationApi;
  final AppLocalStorage _appLocalStorage;

  const AuthenticationRepositoryImpl(
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
    final state = await getStateOf<AuthResponse>(
      request: () async {
        return await _authenticationApi.signIn(body: {
          'email': email,
          'password': password,
        });
      },
    );

    if (state is DataSuccess) {
      await Future.wait(
        [
          _appLocalStorage.saveMap(
            accessTokenKey,
            state.data!.tokens.toMap(),
          )
        ],
      );
      return Left(state.data!.user);
    }

    return Right((state.dioException?.response?.data["message"] ??
        (state.dioException!.message) ??
        "Error while sign in"));
  }

  @override
  Future<bool> logout() async {
    return await Future<bool>.delayed(const Duration(seconds: 2), () => true);
  }

  @override
  Future<Either<UserEntity, String>> register(
      String email, String password) async {
    final state = await getStateOf<AuthResponse>(
      request: () async {
        return await _authenticationApi.signUp(body: {
          'email': email,
          'password': password,
          'source': null,
        });
      },
    );

    if (state is DataSuccess) {
      log(state.data!.toJson());
      await _appLocalStorage.saveMap(
        accessTokenKey,
        state.data!.tokens.toMap(),
      );
      return Left(state.data!.user);
    }
    return Right((state.dioException?.response?.data as Map)["message"] ??
        state.dioException?.message);
  }

  @override
  Future<Either<AuthResponse, String>> refreshToken({
    required String refreshToken,
    required int timezone,
  }) async {
    final state = await getStateOf<AuthResponse>(
      request: () async {
        return await _authenticationApi.refreshToken(
          body: {
            "refreshToken": refreshToken,
            "timezone": refreshToken,
          },
        );
      },
    );

    if (state is DataSuccess) {
      await Future.wait(
        [
          _appLocalStorage.saveMap(
            accessTokenKey,
            state.data!.tokens.toMap(),
          )
        ],
      );
      return Left(state.data!);
    }

    return Right((state.dioException?.response?.data["message"] ??
        (state.dioException!.message) ??
        "Error while refresh token"));
  }

  @override
  Future<Either<DataFailed, DataSuccess>> forgetPassword(String email) async {
    final dataState = await getStateOf<Map<String, dynamic>>(
      request: () => _authenticationApi.forgetPassword(body: {
        "email": email,
      }),
    );

    // if (dataState is DataSuccess) {
    //   return dataState.data?["message"]! ?? "Error while forget password";
    // }
    // return dataState.dioException?.message ??
    //     "Error while forget password" +
    //         (dataState.dioException?.response?.data as Map)["message"];

    if (dataState is DataSuccess) {
      return Right(dataState as DataSuccess);
    }
    return Left(dataState as DataFailed);
  }
}
