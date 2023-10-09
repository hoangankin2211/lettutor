import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/core/components/navigation/routes_service.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';

import 'generated/l10n.dart';
import 'ui/auth/blocs/auth_status.dart';

class Application extends StatefulWidget {
  const Application({
    Key? key,
    this.savedThemeMode,
    required this.initialRoute,
    required this.title,
    required this.providers,
    required this.navigationKey,
    required this.routeService,
  }) : super(key: key);

  final AdaptiveThemeMode? savedThemeMode;
  final String initialRoute;
  final String title;
  final List<BlocProvider> providers;
  final RouteService routeService;
  final GlobalKey<NavigatorState> navigationKey;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
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
    final appRouter = widget.routeService.getRouter();

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
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState.authStatus == AuthStatus.authenticated) {
              appRouter.go(RouteLocation.home);
            } else if (authState.authStatus == AuthStatus.unauthenticated) {
              appRouter.go(RouteLocation.auth);
            }
          },
          child: child!,
        );
      },
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: widget.providers,
      child: AdaptiveTheme(
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        builder: (light, dark) => _buildMaterialApp(
          locale: const Locale("en", ""),
        ),
      ),
    );
  }
}
