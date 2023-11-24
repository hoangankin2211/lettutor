import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';

class AppBlocObserver extends BlocObserver {
  bool _isAuthBloc(BlocBase bloc) => bloc.runtimeType is AuthenticationBloc;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    final message = '[AppBlocObserver] onCreate -- $bloc';
    log(message);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (_isAuthBloc(bloc)) {
      final message = '[AppBlocObserver] onChange -- '
          '${bloc.runtimeType} '
          '${(change.currentState as AuthenticationBloc).state.authStatus} -> ${(change.nextState as AuthenticationBloc).state.authStatus}';
      log(message);
    } else {
      final message = '[AppBlocObserver] onChange -- '
          '${bloc.runtimeType} '
          '${change.currentState.runtimeType} -> ${change.nextState.runtimeType}';
      log(message);
    }
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    final message = '[AppBlocObserver] onError -- $bloc ${error.toString()}'
        '=> stackTrace: ${stackTrace.toString()}';
    log(message);

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);

    final message = '[AppBlocObserver] onClose -- $bloc';
    log(message);
  }
}
