part of 'application_bloc.dart';

abstract class ApplicationEvent {}

class ApplicationInitialEvent extends ApplicationEvent {}

class ChangeThemeModeEvent extends ApplicationEvent {
  final AdaptiveThemeMode themeMode;

  ChangeThemeModeEvent({
    required this.themeMode,
  });
}

class LanguageChangedEvent extends ApplicationEvent {
  final Locale locale;

  LanguageChangedEvent({
    required this.locale,
  });
}
