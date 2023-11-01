// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'package:lettutor/core/utils/navigation/routes_location.dart';

class ApplicationDataState {
  final ThemeMode themeMode;
  final String initialRoute;
  final String language;

  AdaptiveThemeMode get adaptiveThemeMode => switch (themeMode) {
        ThemeMode.system => AdaptiveThemeMode.system,
        ThemeMode.light => AdaptiveThemeMode.light,
        ThemeMode.dark => AdaptiveThemeMode.dark,
      };

  const ApplicationDataState({
    this.language = "en",
    this.themeMode = ThemeMode.system,
    this.initialRoute = RouteLocation.splash,
  });

  ApplicationDataState copyWith({
    ThemeMode? themeMode,
    String? initialRoute,
    String? language,
  }) {
    return ApplicationDataState(
      themeMode: themeMode ?? this.themeMode,
      initialRoute: initialRoute ?? this.initialRoute,
      language: language ?? this.language,
    );
  }
}
