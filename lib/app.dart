import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'generated/l10n.dart';

class Application extends StatefulWidget {
  const Application({
    Key? key,
    this.savedThemeMode,
    required this.initialRoute,
    required this.title,
    required this.providers,
    required this.navigationKey,
    required this.router,
  }) : super(key: key);

  final AdaptiveThemeMode? savedThemeMode;
  final String initialRoute;
  final String title;
  final List<BlocProvider> providers;
  final GoRouter router;
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
      routerDelegate: widget.router.routerDelegate,
      routeInformationParser: widget.router.routeInformationParser,
      routeInformationProvider: widget.router.routeInformationProvider,
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
