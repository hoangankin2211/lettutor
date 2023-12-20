import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/navigation/routes_location.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:flutter_provider/flutter_provider.dart';

import 'core/utils/blocs/app_bloc.dart/application_bloc.dart';
import 'generated/l10n.dart';
import 'ui/auth/blocs/auth_status.dart';

class Application extends StatefulWidget {
  const Application({
    Key? key,
    this.savedThemeMode,
    required this.initialRoute,
    required this.title,
    required this.navigationKey,
    required this.routeService,
  }) : super(key: key);

  final AdaptiveThemeMode? savedThemeMode;
  final String initialRoute;
  final String title;
  final GoRouter routeService;
  final GlobalKey<NavigatorState> navigationKey;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  AuthenticationBloc get authBloc =>
      BlocProvider.of<AuthenticationBloc>(context);

  ApplicationBloc get applicationBloc =>
      BlocProvider.of<ApplicationBloc>(context);

  @override
  void initState() {
    authBloc.add(InitAuthenticationStatus());
    WidgetsBinding.instance.addObserver(this);
    // //Turn off default status bar for application
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _buildMaterialApp({
    Locale? locale,
    ThemeData? light,
    ThemeData? dark,
    ThemeMode? themeMode,
  }) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: widget.title,
        themeMode: themeMode,
        theme: light,
        darkTheme: dark,
        locale: locale,
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerDelegate: widget.routeService.routerDelegate,
        routeInformationParser: widget.routeService.routeInformationParser,
        routeInformationProvider: widget.routeService.routeInformationProvider,
      ),
    );
  }

  void _applicationStateListener(BuildContext context, ApplicationState state) {
    switch (state.runtimeType) {
      case ChangeThemeModeState:
        AdaptiveTheme.of(context).setThemeMode(state.data.adaptiveThemeMode);
        break;
      case ChangeLanguageModeState:
        break;
      default:
    }
  }

  void _authStateListener(BuildContext context, AuthenticationState state) {
    if (state.runtimeType == AuthenticationState) {
      switch (state.authStatus) {
        case AuthStatus.authenticated:
          widget.routeService.go(RouteLocation.dashboard);
          break;
        case AuthStatus.unauthenticated:
          widget.routeService.go(RouteLocation.auth);
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      builder: (light, dark) => BlocConsumer<ApplicationBloc, ApplicationState>(
        listener: _applicationStateListener,
        builder: (context, appState) {
          // SystemChrome.setSystemUIOverlayStyle(
          //   SystemUiOverlayStyle(
          //       statusBarColor: AdaptiveTheme.of(context).theme.scaffoldBackgroundColor,
          //       statusBarIconBrightness: AdaptiveTheme.of(context).brightness == Brightness.light ? Brightness.dark : Brightness.light
          //   ),
          // );
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: _authStateListener,
            child: _buildMaterialApp(
              locale: Locale(appState.data.language),
              light: light,
              dark: dark,
              themeMode: appState.data.themeMode,
            ),
          );
        },
      ),
    );
  }
}
