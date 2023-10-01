import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/app.dart';
import 'package:lettutor/core/components/blocs/app_bloc.dart/application_bloc.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/core/components/navigation/routes_service.dart';

import 'core/components/blocs/app_bloc_observer.dart';
import 'core/components/configuration/configuration.dart';

class AppBuilder {
  static final appNavigationKey = GlobalKey<NavigatorState>();

  static Future<Widget> build(Map<String, dynamic> environment) async {
    WidgetsFlutterBinding.ensureInitialized();

    Configurations.setConfigurationValues(environment);

    //Get old theme
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    //Config getIt dependency
    await configureDependencies(environment: Environment.prod);

    final myBlocObserver = AppBlocObserver();
    Bloc.observer = myBlocObserver;

    final routeService = injector.get<RouteService>().getRouter();

    //Turn off default status bar for application
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return Application(
      initialRoute: RouteLocation.splash,
      title: "Lettutor",
      providers: [
        BlocProvider<ApplicationBloc>(
            create: (context) => injector.get<ApplicationBloc>()),
      ],
      navigationKey: appNavigationKey,
      savedThemeMode: savedThemeMode,
      router: routeService,
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
