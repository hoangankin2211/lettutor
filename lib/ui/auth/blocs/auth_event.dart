part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class ChangeAuthenticationStatus extends AuthEvent {
  final AuthStatus authStatus;

  ChangeAuthenticationStatus({required this.authStatus});
}

class LogoutAuthenticationRequest extends AuthEvent {}

class InitAuthenticationStatus extends AuthEvent {}
