part of 'application_bloc.dart';

abstract class ApplicationEvent {}

class ApplicationInitialEvent extends ApplicationEvent {}

class ChangeThemeModeEvent extends ApplicationEvent {
  final ThemeMode themeMode;

  ChangeThemeModeEvent({
    required this.themeMode,
  });
}

class LanguageChangedEvent extends ApplicationEvent {
  final String language;

  LanguageChangedEvent({
    required this.language,
  });
}
