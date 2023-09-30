import 'dart:async';
import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/app.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/navigation/routes_location.dart';

import 'core/components/blocs/app_bloc_observer.dart';

class AppBuilder {
  static final appNavigationKey = GlobalKey<NavigatorState>();

  static Future<Widget> build(Map<String, dynamic> environment) async {
    WidgetsFlutterBinding.ensureInitialized();

    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    await configureDependencies(environment: Environment.prod);
    final myBlocObserver = AppBlocObserver();
    Bloc.observer = myBlocObserver;
    return Application(
      initialRoute: RouteLocation.splash,
      title: "Lettutor",
      providers: const [],
      navigationKey: appNavigationKey,
      savedThemeMode: savedThemeMode,
    );
  }

  static void run(Map<String, dynamic> env) {
    runZonedGuarded(
      () async => runApp(await build(env)),
      (error, stack) {
        logger.d(error, stackTrace: stack);
      },
    );
  }
}
