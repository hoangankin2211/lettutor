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

  const AuthenticationState.loading(
      {bool isLoading = true, AuthStatus authStatus = AuthStatus.unknown})
      : this._(isLoading: true, authStatus: authStatus);

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

  const AuthenticationState.sendEmailSuccess({required String message})
      : this._(
          authStatus: AuthStatus.sendEmailSuccess,
          message: message,
          isLoading: false,
        );

  const AuthenticationState.registerSuccess({required String message})
      : this._(
          authStatus: AuthStatus.registerSuccess,
          message: message,
          isLoading: false,
        );

  @override
  List<Object?> get props => [authStatus, isLoading, user];
}

enum ChangePasswordStatus {
  init,
  loading,
  success,
  fail,
}

class ChangePassword extends AuthenticationState {
  final ChangePasswordStatus changePasswordStatus;

  bool get isChangingPassword =>
      changePasswordStatus == ChangePasswordStatus.loading;

  const ChangePassword.init({
    this.changePasswordStatus = ChangePasswordStatus.init,
    super.user,
  }) : super._(
          authStatus: AuthStatus.authenticated,
          isLoading: false,
        );

  const ChangePassword.loading({
    this.changePasswordStatus = ChangePasswordStatus.loading,
    super.user,
  }) : super._(
          authStatus: AuthStatus.authenticated,
          isLoading: false,
        );

  const ChangePassword.success(
    String message, {
    this.changePasswordStatus = ChangePasswordStatus.success,
    super.user,
  }) : super._(
          message: message,
          authStatus: AuthStatus.authenticated,
          isLoading: false,
        );

  const ChangePassword.fail(
    String message, {
    this.changePasswordStatus = ChangePasswordStatus.fail,
    super.user,
  }) : super._(
          message: message,
          authStatus: AuthStatus.authenticated,
          isLoading: false,
        );
}
