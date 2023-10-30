import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/app_init.dart';
import 'package:lettutor/core/utils/navigation/error_screen.dart';
import 'package:lettutor/core/utils/navigation/routes_location.dart';
import 'package:lettutor/ui/auth/views/auth_screen.dart';
import 'package:lettutor/ui/course/views/course_detail_screen.dart';
import 'package:lettutor/ui/course/views/widgets/page_view_pdf.dart';
import 'package:lettutor/ui/dashboard/views/dashboard_screen.dart';
import 'package:lettutor/ui/history/views/history_screen.dart';
import 'package:lettutor/ui/home/views/home_screen.dart';
import 'package:lettutor/ui/setting/views/profile_screen.dart';
import 'package:lettutor/ui/setting/views/setting_screen.dart';
import 'package:lettutor/ui/splash/splash_screen.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_detail_bloc.dart';
import 'package:lettutor/ui/tutor/views/tutor_booking_time_screen.dart';
import 'package:lettutor/ui/tutor/views/tutor_detail_screen.dart';

import '../../../ui/schedule/view/meeting_room_screen.dart';

final routes = [
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.home,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.tutorDetail,
    builder: (context, state) {
      final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
      if (extra != null) {
        final String? tutorId = extra["tutorId"];
        if (tutorId != null) {
          return TutorDetailScreen(tutorId: tutorId);
        }
      }
      return const ErrorScreen(text: "Can not open this tutor profile detail");
    },
  ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.courseDetail,
    builder: (context, state) {
      if (state.extra != null && state.extra is Map) {
        final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        final String? courseId = data["courseId"];
        final String? from = data["from"];
        if (courseId != null) {
          return CourseDetailScreen(
            courseId: courseId,
            key: ValueKey("${courseId}_$from"),
          );
        }
      }
      return const ErrorScreen();
    },
    routes: [
      GoRoute(
        path: RouteLocation.topicDetail,
        builder: (context, state) {
          final Map<String, dynamic>? extra =
              state.extra as Map<String, dynamic>?;
          if (extra != null) {
            final String? pdfUrl = extra["pdfUrl"]!;
            if (pdfUrl != null && pdfUrl.isNotEmpty) {
              return PdfViewerPage(pdfUrl: pdfUrl);
            }
          }
          return const ErrorScreen(text: "No pdf found");
        },
      ),
    ],
  ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.booking,
    builder: (context, state) {
      if (state.extra != null && state.extra is Map) {
        final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        final TutorDetailBloc? tutorDetailBloc = data["tutorDetailBloc"];
        if (tutorDetailBloc != null) {
          return TutorBookingTimeScreen(tutorDetailBloc: tutorDetailBloc);
        }
      }
      return const ErrorScreen();
    },
  ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.dashboard,
    builder: (context, state) => const DashboardScreen(),
  ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.meeting,
    builder: (context, state) {
      if (state.extra != null && state.extra is Map) {
        final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        final String? meetingUrl = data["meetingUrl"];
        if (meetingUrl != null) {
          return MeetingRoomScreen(meetingUrl: meetingUrl);
        }
      }
      return const ErrorScreen();
    },
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
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.setting,
    builder: (context, state) => const SettingScreen(),
    routes: [
      GoRoute(
        path: RouteLocation.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteLocation.history,
        builder: (context, state) => const HistoryScreen(),
      ),
    ],
  ),
];
