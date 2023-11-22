part of 'auth_bloc.dart';

@immutable
class AuthenticationState extends Equatable {
  final AuthStatus authStatus;
  final User? user;
  final String? message;
  final bool isLoading;

  const AuthenticationState._({
    this.authStatus = AuthStatus.unknown,
    this.user,
    this.message,
    this.isLoading = false,
  });

  const AuthenticationState.unknown({bool isLoading = false}) : this._();

  const AuthenticationState.loading({bool isLoading = true})
      : this._(isLoading: true);

  const AuthenticationState.authenticated(
      {required User user, bool isLoading = false})
      : this._(
          authStatus: AuthStatus.authenticated,
          user: user,
          isLoading: isLoading,
        );

  const AuthenticationState.unauthenticated(
      {required String message, bool isLoading = false})
      : this._(
          authStatus: AuthStatus.unauthenticated,
          message: message,
          isLoading: isLoading,
        );

  @override
  List<Object?> get props => [authStatus, isLoading, user];
}
