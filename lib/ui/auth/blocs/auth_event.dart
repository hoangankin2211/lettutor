part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class EmailLoginRequest extends AuthEvent {
  final String email;
  final String password;
  EmailLoginRequest({
    required this.email,
    required this.password,
  });
}

class LogoutAuthenticationRequest extends AuthEvent {}

class InitAuthenticationStatus extends AuthEvent {}

class RefreshTokenRequest extends AuthEvent {
  final String refreshToken;

  RefreshTokenRequest(this.refreshToken);
}

class EmailRegisterRequest extends AuthEvent {
  final String email;
  final String password;
  EmailRegisterRequest({
    required this.email,
    required this.password,
  });
}
