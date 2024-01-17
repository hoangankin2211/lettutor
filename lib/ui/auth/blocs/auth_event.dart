part of 'auth_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class EmailLoginRequest extends AuthenticationEvent {
  final String email;
  final String password;
  EmailLoginRequest({
    required this.email,
    required this.password,
  });
}

class LogoutAuthenticationRequest extends AuthenticationEvent {}

class InitAuthenticationStatus extends AuthenticationEvent {}

class RefreshTokenRequest extends AuthenticationEvent {
  final String refreshToken;

  RefreshTokenRequest(this.refreshToken);
}

class EmailRegisterRequest extends AuthenticationEvent {
  final String email;
  final String password;
  EmailRegisterRequest({
    required this.email,
    required this.password,
  });
}

class ForgetPasswordRequest extends AuthenticationEvent {
  final String email;
  ForgetPasswordRequest(this.email);
}

class InitChangePasswordFlow extends AuthenticationEvent {
  InitChangePasswordFlow();
}

class GoogleSignInRequest extends AuthenticationEvent {
  GoogleSignInRequest();
}

class FacebookSignInRequest extends AuthenticationEvent {
  FacebookSignInRequest();
}

class ChangePasswordRequest extends AuthenticationEvent {
  final String password;
  final String newPassword;
  ChangePasswordRequest({
    required this.password,
    required this.newPassword,
  });
}
