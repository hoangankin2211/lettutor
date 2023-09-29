import 'package:go_router/go_router.dart';
import 'package:lettutor/core/navigation/routes_location.dart';

final routes = [
  GoRoute(
    path: RouteLocation.auth,
  ),
  GoRoute(
    path: RouteLocation.detailScreen,
  ),
  GoRoute(
    path: RouteLocation.profile,
  ),
  GoRoute(
    path: RouteLocation.search,
  ),
  GoRoute(
    path: RouteLocation.settings,
  ),
  GoRoute(
    path: RouteLocation.splash,
  ),
];
