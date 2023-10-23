import 'package:flutter/foundation.dart' show immutable;

@immutable
class RouteLocation {
  const RouteLocation._();
  //routeLocation
  static const String home = '/home';
  static const String history = 'history';
  static const String topicDetail = 'topicDetail';
  static const String dashboard = '/';
  static const String splash = '/splash';
  static const String courseDetail = '/courseDetail';
  static const String setting = '/setting';
  static const String search = '/search';
  static const String auth = '/auth';
  static const String tutorDetail = '/tutorDetail';
  static const String profile = 'profile';
}
