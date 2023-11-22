import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/app.dart';
import 'package:lettutor/core/configuration/configuration_service.dart';
import 'package:lettutor/core/utils/blocs/app_bloc.dart/application_bloc.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/utils/navigation/routes_location.dart';
import 'package:lettutor/core/utils/navigation/routes_service.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';

import 'core/utils/blocs/app_bloc_observer.dart';
import 'core/configuration/configuration.dart';

class AppBuilder {
  static final appNavigationKey = GlobalKey<NavigatorState>();

  static Future<Widget> build(String configUrl) async {
    WidgetsFlutterBinding.ensureInitialized();

    Configurations.setConfigurationValues(await getConfigFromJson(configUrl));

    //Get old theme
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    //Config getIt dependency
    await configureDependencies(environment: Environment.prod);

    final myBlocObserver = AppBlocObserver();
    Bloc.observer = myBlocObserver;

    //Get routeService
    final routeService = injector.get<RouteService>().getRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (context) => injector.get<ApplicationBloc>(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => injector.get<AuthenticationBloc>(),
        ),
      ],
      child: Application(
        initialRoute: RouteLocation.splash,
        title: "LetTutor",
        navigationKey: appNavigationKey,
        savedThemeMode: savedThemeMode,
        routeService: routeService,
      ),
    );
  }

  static void run(String configUrl) {
    runZonedGuarded(
      () async => runApp(await build(configUrl)),
      (error, stack) {
        logger.d(error, stackTrace: stack);
      },
    );
  }
}
