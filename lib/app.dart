import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';

import 'core/components/blocs/app_bloc.dart/application_bloc.dart';
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
  late final authBloc = BlocProvider.of<AuthBloc>(context);

  @override
  void initState() {
    authBloc.add(InitAuthenticationStatus());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _buildMaterialApp({
    required Locale locale,
    ThemeData? light,
    ThemeData? dark,
  }) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: widget.title,
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
    );
  }

  void _applicationStateListener(BuildContext context, ApplicationState state) {
    switch (state) {
      default:
    }
  }

  void _authStateListener(BuildContext context, AuthState state) {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicationBloc, ApplicationState>(
      listener: _applicationStateListener,
      builder: (context, appState) {
        return AdaptiveTheme(
          initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
          light: ThemeData.light(),
          dark: ThemeData.dark(),
          builder: (light, dark) => BlocListener<AuthBloc, AuthState>(
            listener: _authStateListener,
            child: _buildMaterialApp(locale: const Locale("en", "")),
          ),
        );
      },
    );
  }
}
