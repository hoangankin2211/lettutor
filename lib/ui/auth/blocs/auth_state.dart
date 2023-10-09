part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  final AuthStatus authStatus;
  final User? user;
  final String? message;

  const AuthState._({
    this.authStatus = AuthStatus.unknown,
    this.user,
    this.message,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({required User user})
      : this._(
          authStatus: AuthStatus.authenticated,
          user: user,
        );

  const AuthState.unauthenticated({required String message})
      : this._(authStatus: AuthStatus.unauthenticated, message: message);

  @override
  List<Object?> get props => [authStatus, user];
}
