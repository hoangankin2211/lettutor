import 'package:go_router/go_router.dart';
import 'package:lettutor/app.dart';
import 'package:lettutor/app_init.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/ui/home/views/home_screen.dart';
import 'package:lettutor/ui/splash/splash_screen.dart';

final routes = [
  // GoRoute(
  //   path: RouteLocation.auth,
  // ),
  // GoRoute(
  //   path: RouteLocation.detailScreen,
  // ),
  // GoRoute(
  //   path: RouteLocation.profile,
  // ),
  // GoRoute(
  //   path: RouteLocation.search,
  // ),
  // GoRoute(
  //   path: RouteLocation.settings,
  // ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.auth,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: RouteLocation.splash,
    parentNavigatorKey: AppBuilder.appNavigationKey,
    builder: (context, state) => const SplashScreen(),
  ),
];
