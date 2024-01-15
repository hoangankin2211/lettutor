import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/app_init.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/navigation/error_screen.dart';
import 'package:lettutor/data/entities/chat/message_entity.dart';
import 'package:lettutor/ui/auth/views/auth_screen.dart';
import 'package:lettutor/ui/chat/chat_screen.dart';
import 'package:lettutor/ui/course/views/course_detail_screen.dart';
import 'package:lettutor/ui/course/views/widgets/page_view_pdf.dart';
import 'package:lettutor/ui/dashboard/views/dashboard_screen.dart';
import 'package:lettutor/ui/history/views/history_screen.dart';
import 'package:lettutor/ui/home/views/home_screen.dart';
import 'package:lettutor/ui/setting/views/setting_screen.dart';
import 'package:lettutor/ui/setting/views/widgets/become_tutor_screen.dart';
import 'package:lettutor/ui/setting/views/widgets/change_password_screen.dart';
import 'package:lettutor/ui/setting/views/widgets/profile_screen.dart';
import 'package:lettutor/ui/splash/splash_screen.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_detail_bloc.dart';
import 'package:lettutor/ui/tutor/views/tutor_booking_time_screen.dart';
import 'package:lettutor/ui/tutor/views/tutor_detail_screen.dart';

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
      return ErrorScreen(text: context.l10n.notOpenTutorProfile);
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
          return ErrorScreen(text: context.l10n.noPdfFound);
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
    path: RouteLocation.chatScreen,
    builder: (context, state) {
      if (state.extra != null && state.extra is Map) {
        final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        final MessageEntity? messageEntity = data["messageEntity"];
        final String? partnerId = data["partnerId"];
        if (messageEntity != null && partnerId != null) {
          return ChatScreen(messageEntity: messageEntity, partnerId: partnerId);
        }
      }
      return const ErrorScreen();
    },
  ),
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.becomeTutor,
    builder: (context, state) => const BecomeTutorScreen(),
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
  GoRoute(
    parentNavigatorKey: AppBuilder.appNavigationKey,
    path: RouteLocation.setting,
    builder: (context, state) => const SettingScreen(),
    routes: [
      GoRoute(
        parentNavigatorKey: AppBuilder.appNavigationKey,
        path: RouteLocation.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        parentNavigatorKey: AppBuilder.appNavigationKey,
        path: RouteLocation.changePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: RouteLocation.history,
        builder: (context, state) => const HistoryScreen(),
      ),
    ],
  ),
];
