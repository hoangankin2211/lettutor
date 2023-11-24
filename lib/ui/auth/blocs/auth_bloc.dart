import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/data_source/local/authentication/auth_local_data.dart';
import 'package:lettutor/data/data_source/remote/user/user_service.dart';
import 'package:lettutor/data/entities/token_entity.dart';
import 'package:lettutor/domain/mapper/user_mapper.dart';
import 'package:lettutor/domain/usecases/auth_usecase.dart';
import 'package:lettutor/ui/auth/blocs/auth_status.dart';

import '../../../domain/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthUseCase authUseCase;
  final UserService userService;
  final AuthLocalData _authLocalData;

  AuthenticationBloc(
    this.authUseCase,
    this._authLocalData,
    this.userService,
  ) : super(const AuthenticationState.unknown()) {
    on<EmailLoginRequest>(_onEmailLoginRequest);
    on<LogoutAuthenticationRequest>(_onLogoutAuthenticationRequest);
    on<InitAuthenticationStatus>(_onInitAuthenticationStatus);
    on<EmailRegisterRequest>(_onEmailRegisterRequest);
    on<RefreshTokenRequest>(_onRefreshTokenRequest);
  }

  FutureOr<void> _onInitAuthenticationStatus(
      InitAuthenticationStatus event, Emitter<AuthenticationState> emit) async {
    try {
      final Either<String, TokenEntity> tokenLocal =
          await _authLocalData.getToken();

      if (tokenLocal.isLeft) {
        return emit(
            AuthenticationState.unauthenticated(message: tokenLocal.left));
      }

      final TokenEntity tokenEntity = tokenLocal.right;

      final accessExpiredTime = DateTime.parse(tokenEntity.access.expires);

      if (accessExpiredTime.isBefore(DateTime.now())) {
        final refreshExpiredTime = DateTime.parse(tokenEntity.refresh.expires);

        if (refreshExpiredTime.isBefore(DateTime.now())) {
          emit(const AuthenticationState.unauthenticated(
              message: "Refresh Token has expired"));
          return;
        }

        add(RefreshTokenRequest(tokenEntity.refresh.token));
      } else {
        emit(
          AuthenticationState.authenticated(
            user: UserMapper.fromUserInfoEntity(
                (await userService.getUserInfo()).data.user),
          ),
        );
      }
    } catch (e) {
      emit(AuthenticationState.unauthenticated(message: e.toString()));
    }
  }

  FutureOr<void> _onEmailLoginRequest(
      EmailLoginRequest event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.loading());
    (await authUseCase.signInEmail(event.email, event.password)).fold(
      (user) => emit(AuthenticationState.authenticated(user: user)),
      (errorMessage) =>
          emit(AuthenticationState.unauthenticated(message: errorMessage)),
    );
  }

  FutureOr<void> _onEmailRegisterRequest(
      EmailRegisterRequest event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.loading());

    (await authUseCase.signUpEmail(event.email, event.password)).fold(
      (left) {
        emit(AuthenticationState.authenticated(user: left));
      },
      (right) => emit(AuthenticationState.unauthenticated(message: right)),
    );
  }

  FutureOr<void> _onLogoutAuthenticationRequest(
    LogoutAuthenticationRequest event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.loading());
    if (await authUseCase.logout()) {
      await _authLocalData.deleteToken();
      return emit(const AuthenticationState.unauthenticated(message: "Logout"));
    }
    return emit(const AuthenticationState.unknown());
  }

  FutureOr<void> _onRefreshTokenRequest(
      RefreshTokenRequest event, Emitter<AuthenticationState> emit) async {
    await authUseCase
        .refreshToken(refreshToken: event.refreshToken, timezone: 7)
        .then(
          (value) => value.fold(
            (left) => emit(AuthenticationState.authenticated(user: left)),
            (right) => emit(const AuthenticationState.unknown()),
          ),
        );
  }
}
