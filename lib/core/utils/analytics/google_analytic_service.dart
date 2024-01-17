import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';

@singleton
class GoogleAnalyticService {
  late final FirebaseAnalytics _analytics;

  GoogleAnalyticService() {
    // _analytics = FirebaseAnalytics.instance;
  }

  Future<void> sendEvent(String name, Map<String, dynamic> params) async {
    try {
      await _analytics.logEvent(name: name, parameters: params);
    } catch (e) {
      logger.d(e.toString());
    }
  }
}

enum AnalyticEvent {
  bookTutor,
  openTutorDetail,
  attendCourse,
  openCourse,
}

extension AnalyticEventExtension on AnalyticEvent {
  String get name {
    switch (this) {
      case AnalyticEvent.bookTutor:
        return 'book_tutor';
      case AnalyticEvent.openTutorDetail:
        return 'open_tutor_detail';
      case AnalyticEvent.attendCourse:
        return 'attend_course';
      case AnalyticEvent.openCourse:
        return 'open_course';
    }
  }
}
