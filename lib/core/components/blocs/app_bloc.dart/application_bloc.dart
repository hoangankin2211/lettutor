import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'application_data_state.dart';

part 'application_state.dart';
part 'application_event.dart';

@injectable
class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc()
      : super(ApplicationInitialState(data: const ApplicationDataState())) {
    on<ApplicationInitialEvent>(onApplicationInitialEvent);
    on<ChangeThemeModeEvent>(onChangeThemeModeEvent);
    on<LanguageChangedEvent>(onChangeLanguageEvent);
  }

  FutureOr<void> onApplicationInitialEvent(
    ApplicationInitialEvent event,
    Emitter<ApplicationState> emit,
  ) async {
    emit(
      ApplicationInitialState(
        data: const ApplicationDataState(
          themeMode: AdaptiveThemeMode.light,
          initialRoute: '/',
        ),
      ),
    );
  }

  FutureOr<void> onChangeThemeModeEvent(
    ChangeThemeModeEvent event,
    Emitter<ApplicationState> emit,
  ) async {
    emit(
      ApplicationInitialState(
        data: state.data.copyWith(
          themeMode: event.themeMode,
        ),
      ),
    );
  }

  FutureOr<void> onChangeLanguageEvent(
    LanguageChangedEvent event,
    Emitter<ApplicationState> emit,
  ) async {
    emit(
      ApplicationInitialState(
        data: state.data.copyWith(),
      ),
    );
  }
}
