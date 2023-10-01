// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/widgets.dart';

class ApplicationDataState {
  final AdaptiveThemeMode themeMode;
  final Locale locale;
  final String initialRoute;
  final bool isAlreadyShowIntro;

  const ApplicationDataState({
    required this.themeMode,
    required this.locale,
    required this.initialRoute,
    required this.isAlreadyShowIntro,
  });

  ApplicationDataState copyWith({
    AdaptiveThemeMode? themeMode,
    Locale? locale,
    String? initialRoute,
    bool? isAlreadyShowIntro,
  }) {
    return ApplicationDataState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      initialRoute: initialRoute ?? this.initialRoute,
      isAlreadyShowIntro: isAlreadyShowIntro ?? this.isAlreadyShowIntro,
    );
  }
}
