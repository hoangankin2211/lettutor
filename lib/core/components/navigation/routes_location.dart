import 'package:flutter/foundation.dart' show immutable;

@immutable
class RouteLocation {
  const RouteLocation._();
  //routeLocation
  static const String home = '/';
  static const String splash = '/splash';
  static const String detailScreen = '/quoteDetails';
  static const String settings = '/settings';
  static const String search = '/search';
  static const String auth = '/auth';
  static const String profile = '/profile';
}
