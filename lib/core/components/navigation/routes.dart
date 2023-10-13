import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/app_init.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/ui/auth/views/auth_screen.dart';
import 'package:lettutor/ui/course/views/course_detail_screen.dart';
import 'package:lettutor/ui/dashboard/views/dashboard_screen.dart';
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
    path: RouteLocation.home,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.courseDetail,
    builder: (context, state) {
      if (state.extra != null && state.extra is Map) {
        print("Here");
        final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        final String courseId = data["courseId"];
        return CourseDetailScreen(courseId: courseId);
      }
      return const Material(
        child: Center(
          child: Text(
            "Error",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      );
    },
  ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.dashboard,
    builder: (context, state) => const DashboardScreen(),
  ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.auth,
    builder: (context, state) => const AuthScreen(),
  ),
  GoRoute(
    path: RouteLocation.splash,
    parentNavigatorKey: AppBuilder.appNavigationKey,
    builder: (context, state) => const SplashScreen(),
  ),
];
