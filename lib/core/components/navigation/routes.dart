import 'package:go_router/go_router.dart';
import 'package:lettutor/app/app_init.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/ui/chat/chat_screen.dart';

final routes = <GoRoute>[
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.chat,
    builder: (context, state) => const ChatScreen(),
  ),
  // GoRoute(
  //   parentNavigatorKey: AppBuilder.appNavigationKey,
  //   path: RouteLocation.auth,
  //   builder: (context, state) => const SignInScreen(),
  // ),
  // GoRoute(
  //   path: RouteLocation.splash,
  //   parentNavigatorKey: AppBuilder.appNavigationKey,
  //   builder: (context, state) => const SplashScreen(),
  // ),
];
