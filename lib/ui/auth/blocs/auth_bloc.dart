import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/networking/interceptor/api_token_interceptor.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';
import 'package:lettutor/data/data_source/remote/user/user_service.dart';
import 'package:lettutor/data/entities/token_entity.dart';
import 'package:lettutor/domain/mapper/user_mapper.dart';
import 'package:lettutor/domain/usecases/auth_usecase.dart';
import 'package:lettutor/ui/auth/blocs/auth_status.dart';

import '../../../domain/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;
  final UserService userService;
  final AppLocalStorage _appLocalStorage;

  AuthBloc(this.authUseCase, this._appLocalStorage, this.userService)
      : super(const AuthState.unknown()) {
    on<EmailLoginRequest>(_onEmailLoginRequest);
    on<LogoutAuthenticationRequest>(_onLogoutAuthenticationRequest);
    on<InitAuthenticationStatus>(_onInitAuthenticationStatus);
    on<EmailRegisterRequest>(_onEmailRegisterRequest);
    on<RefreshTokenRequest>(_onRefreshTokenRequest);
  }

  FutureOr<void> _onInitAuthenticationStatus(
      InitAuthenticationStatus event, Emitter<AuthState> emit) async {
    final tokenMap = _appLocalStorage.getMap(accessTokenKey);

    if (tokenMap?.isNotEmpty ?? false) {
      try {
        final TokenEntity tokenEntity =
            TokenEntity.fromJson(tokenMap!.convertMapDynamicToString());

        final accessExpiredTime = DateTime.parse(tokenEntity.access.expires);

        if (accessExpiredTime.isBefore(DateTime.now())) {
          final refreshExpiredTime =
              DateTime.parse(tokenEntity.refresh.expires);

          if (refreshExpiredTime.isBefore(DateTime.now())) {
            emit(const AuthState.unauthenticated(
                message: "Refresh Token has expired"));
            return;
          }

          add(RefreshTokenRequest(tokenEntity.refresh.token));
        } else {
          emit(
            AuthState.authenticated(
              user: UserMapper.fromUserInfoEntity(
                  (await userService.getUserInfo()).data.user),
            ),
          );
        }
      } catch (e) {
        logger.d(e.toString());
        emit(AuthState.unauthenticated(message: e.toString()));
      }
    } else {
      emit(const AuthState.unauthenticated(message: ""));
    }
  }

  FutureOr<void> _onEmailLoginRequest(
      EmailLoginRequest event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    (await authUseCase.signInEmail(event.email, event.password)).fold(
      (left) {
        emit(AuthState.authenticated(user: left));
      },
      (right) => emit(AuthState.unauthenticated(message: right)),
    );
  }

  FutureOr<void> _onEmailRegisterRequest(
      EmailRegisterRequest event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    (await authUseCase.signUpEmail(event.email, event.password)).fold(
      (left) {
        emit(AuthState.authenticated(user: left));
      },
      (right) => emit(AuthState.unauthenticated(message: right)),
    );
  }

  FutureOr<void> _onLogoutAuthenticationRequest(
      LogoutAuthenticationRequest event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    if (await authUseCase.logout()) {
      return emit(const AuthState.unauthenticated(message: "Logout"));
    }
    return emit(const AuthState.unknown());
  }

  FutureOr<void> _onRefreshTokenRequest(
      RefreshTokenRequest event, Emitter<AuthState> emit) async {
    await authUseCase
        .refreshToken(refreshToken: event.refreshToken, timezone: 7)
        .then(
          (value) => value.fold(
            (left) => emit(AuthState.authenticated(user: left)),
            (right) => emit(const AuthState.unknown()),
          ),
        );
  }
}
