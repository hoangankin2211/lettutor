import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/components/blocs/app_bloc.dart/application_bloc.dart';
import 'package:lettutor/generated/l10n.dart';

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
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicationBloc, ApplicationState>(
      listener: _applicationStateListener,
      builder: (context, appState) {
        return AdaptiveTheme(
          initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
          light: ThemeData.light(),
          dark: ThemeData.dark(),
          builder: (light, dark) =>
              _buildMaterialApp(locale: const Locale("en", "")),
        );
      },
    );
  }
}
