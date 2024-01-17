import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/utils/blocs/app_bloc_observer.dart';
import 'core/configuration/configuration.dart';

class AppBuilder {
  static final appNavigationKey = GlobalKey<NavigatorState>();

  static Future<Widget> build(String configUrl) async {
    final transaction = Sentry.startTransaction('buildApp', 'task');

    try {
      WidgetsFlutterBinding.ensureInitialized();
      // await Firebase.initializeApp();

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
    } on Exception catch (e) {
      transaction.throwable = e;
      transaction.status = const SpanStatus.internalError();

      logger.e(e);

      rethrow;
    } finally {
      transaction.finish();
    }
  }

  static void run(String configUrl) async {
    runZonedGuarded(
      () async => await SentryFlutter.init(
        (options) {
          options.dsn =
              'https://21c20bd7feea03e85fbaddfa51a55789@o4506585949536256.ingest.sentry.io/4506585951895552';
          // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
          // We recommend adjusting this value in production.
          options.tracesSampleRate = 1.0;
        },
        appRunner: () async => runApp(await build(configUrl)),
      ),
      (error, stack) {
        logger.d(error, stackTrace: stack);
      },
    );
  }
}
