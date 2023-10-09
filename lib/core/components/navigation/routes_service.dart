import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/app_init.dart';
import 'package:lettutor/core/components/navigation/error_screen.dart';
import 'package:lettutor/core/components/navigation/routes.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';

@injectable
class RouteService {
  GoRouter getRouter({
    FutureOr<String?> Function(BuildContext, GoRouterState)? redirect,
    List<GoRoute>? customRoutes,
  }) {
    return GoRouter(
      initialLocation: RouteLocation.splash,
      navigatorKey: AppBuilder.appNavigationKey,
      routes: customRoutes ?? routes,
      errorBuilder: (context, state) => const ErrorScreen(),
      redirect: redirect,
    );
  }
}
