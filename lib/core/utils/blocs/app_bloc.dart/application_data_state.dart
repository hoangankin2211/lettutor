// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:lettutor/core/utils/navigation/routes_location.dart';

class ApplicationDataState {
  final AdaptiveThemeMode themeMode;
  final String initialRoute;

  const ApplicationDataState({
    this.themeMode = AdaptiveThemeMode.system,
    this.initialRoute = RouteLocation.splash,
  });

  ApplicationDataState copyWith({
    AdaptiveThemeMode? themeMode,
    String? initialRoute,
  }) {
    return ApplicationDataState(
      themeMode: themeMode ?? this.themeMode,
      initialRoute: initialRoute ?? this.initialRoute,
    );
  }
}
