// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class EmailRegisterRequest extends AuthEvent {
  final String email;
  final String password;
  EmailRegisterRequest({
    required this.email,
    required this.password,
  });
}
