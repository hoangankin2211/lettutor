import 'package:flutter/foundation.dart' show immutable;

@immutable
class RouteLocation {
  const RouteLocation._();
  //routeLocation
  static String get splash => '/splash';
  static String get detailScreen => '/quoteDetails';
  static String get settings => '/settings';
  static String get search => '/search';
  static String get auth => '/auth';
  static String get profile => '/profile';
}
