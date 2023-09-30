import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lettutor/core/dependecy_injection/di.dart';
import 'package:lettutor/core/navigation/routes_service.dart';

import 'generated/l10n.dart';

class Application extends StatefulWidget {
  const Application({
    Key? key,
    this.savedThemeMode,
    required this.initialRoute,
    required this.title,
    required this.providers,
    required this.navigationKey,
  }) : super(key: key);

  final AdaptiveThemeMode? savedThemeMode;
  final String initialRoute;
  final String title;
  final List<BlocProvider> providers;
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
    final routeService = injector.get<RouteService>().getRouter();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      theme: light,
      darkTheme: dark,
      locale: locale,
      routerDelegate: routeService.routerDelegate,
      routeInformationParser: routeService.routeInformationParser,
      routeInformationProvider: routeService.routeInformationProvider,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      builder: (light, dark) => _buildMaterialApp(locale: Locale("en", "")),
    );
  }
}
