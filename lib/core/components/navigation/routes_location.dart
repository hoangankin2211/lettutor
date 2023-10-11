import 'package:flutter/foundation.dart' show immutable;

@immutable
class RouteLocation {
  const RouteLocation._();
  //routeLocation
  static const String home = '/home';
  static const String dashboard = '/';
  static const String splash = '/splash';
  static const String courseDetail = 'courseDetail';
  static const String settings = '/settings';
  static const String search = '/search';
  static const String auth = '/auth';
  static const String profile = '/profile';
}
