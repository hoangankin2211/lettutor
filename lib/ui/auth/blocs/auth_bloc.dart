import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/components/networking/interceptor/api_token_interceptor.dart';
import 'package:lettutor/domain/usecases/auth_usecase.dart';
import 'package:lettutor/ui/auth/blocs/auth_status.dart';

import '../../../data/data_source/local/app_local_storage.dart';
import '../../../domain/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc(this.authUseCase) : super(const AuthState.unknown()) {
    on<EmailLoginRequest>(_onEmailLoginRequest);
    on<LogoutAuthenticationRequest>(_onLogoutAuthenticationRequest);
    on<InitAuthenticationStatus>(_onInitAuthenticationStatus);
    on<EmailRegisterRequest>(_onEmailRegisterRequest);
  }

  FutureOr<void> _onInitAuthenticationStatus(
      InitAuthenticationStatus event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    emit(const AuthState.unauthenticated(message: "Not Sign In yet"));
  }

  FutureOr<void> _onEmailLoginRequest(
      EmailLoginRequest event, Emitter<AuthState> emit) async {
    (await authUseCase.signInEmail(event.email, event.password)).fold(
      (left) {
        emit(AuthState.authenticated(user: left));
      },
      (right) => emit(AuthState.unauthenticated(message: right)),
    );
  }

  FutureOr<void> _onEmailRegisterRequest(
      EmailRegisterRequest event, Emitter<AuthState> emit) async {
    (await authUseCase.signUpEmail(event.email, event.password)).fold(
      (left) {
        emit(AuthState.authenticated(user: left));
      },
      (right) => emit(AuthState.unauthenticated(message: right)),
    );
  }

  FutureOr<void> _onLogoutAuthenticationRequest(
      LogoutAuthenticationRequest event, Emitter<AuthState> emit) async {
    emit(const AuthState.unauthenticated(message: "Logout"));
  }
}
