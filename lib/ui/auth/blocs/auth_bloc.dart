import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/ui/auth/blocs/auth_status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    on<ChangeAuthenticationStatus>(_onChangeAuthenticationStatus);
    on<LogoutAuthenticationRequest>(_onLogoutAuthenticationRequest);
    on<InitAuthenticationStatus>(_onInitAuthenticationStatus);
  }

  FutureOr<void> _onInitAuthenticationStatus(
      InitAuthenticationStatus event, Emitter<AuthState> emit) async {}

  FutureOr<void> _onLogoutAuthenticationRequest(
      LogoutAuthenticationRequest event, Emitter<AuthState> emit) async {
    emit(const AuthState.unauthenticated());
  }

  FutureOr<void> _onChangeAuthenticationStatus(
      ChangeAuthenticationStatus event, Emitter<AuthState> emit) async {
    emit(AuthState._(authStatus: event.authStatus));
  }
}
