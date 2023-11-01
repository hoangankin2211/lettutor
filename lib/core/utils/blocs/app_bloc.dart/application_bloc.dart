import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/constants.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';

import 'application_data_state.dart';

part 'application_state.dart';
part 'application_event.dart';

@injectable
class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final AppLocalStorage appLocalStorage;
  ApplicationBloc(this.appLocalStorage)
      : super(ApplicationInitialState(data: const ApplicationDataState())) {
    on<ApplicationInitialEvent>(onApplicationInitialEvent);
    on<ChangeThemeModeEvent>(onChangeThemeModeEvent);
    on<LanguageChangedEvent>(onChangeLanguageEvent);
  }

  ApplicationDataState get initApplicationData {
    final language = appLocalStorage.getString(languageKey) ?? "en";
    final ThemeMode themeMode =
        switch (appLocalStorage.getString(themeModeKey)) {
      "light" => ThemeMode.light,
      "dark" => ThemeMode.dark,
      "system" => ThemeMode.system,
      _ => ThemeMode.system,
    };
    return ApplicationDataState(
      language: language,
      themeMode: themeMode,
      initialRoute: '/',
    );
  }

  FutureOr<void> onApplicationInitialEvent(
    ApplicationInitialEvent event,
    Emitter<ApplicationState> emit,
  ) async {
    emit(ApplicationInitialState(data: initApplicationData));
  }

  FutureOr<void> onChangeThemeModeEvent(
    ChangeThemeModeEvent event,
    Emitter<ApplicationState> emit,
  ) async {
    await appLocalStorage.saveString(themeModeKey, event.themeMode.name);
    emit(ChangeThemeModeState(
        data: state.data.copyWith(themeMode: event.themeMode)));
  }

  FutureOr<void> onChangeLanguageEvent(
    LanguageChangedEvent event,
    Emitter<ApplicationState> emit,
  ) async {
    await appLocalStorage.saveString(languageKey, event.language);
    emit(
      ChangeLanguageModeState(
        data: state.data.copyWith(language: event.language),
      ),
    );
  }
}
