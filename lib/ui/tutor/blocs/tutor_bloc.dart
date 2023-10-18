import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';

import '../../../domain/models/tutor/tutor.dart';

part 'tutor_state.dart';

@injectable
class TutorBloc extends Cubit<TutorState> {
  final TutorUseCase tutorUseCase;

  TutorBloc(this.tutorUseCase)
      : super(const TutorInitial(data: TutorDataState()));

  Future<void> loadTutor({int page = 1, int perPage = 10}) async {
    emit(TutorLoading(data: state.data));

    final response =
        await tutorUseCase.fetchTutorPage(page: page, perPage: perPage);

    response.fold((left) {
      emit(TutorError(data: state.data, message: left));
    }, (right) {
      emit(
        TutorLoaded(
            data: state.data.copyWith(
          tutors: right.rows,
          count: right.count,
          page: right.currentPage,
        )),
      );
    });
  }

  void loadMoreTutor({required int page, int perPage = 10}) async {
    if (state.data.page > state.data.totalPage) {
      return;
    }

    final response =
        await tutorUseCase.fetchTutorPage(page: page, perPage: perPage);

    response.fold((left) {
      emit(TutorError(data: state.data, message: left));
    }, (right) {
      emit(
        TutorLoaded(
            data: state.data.copyWith(
          tutors: state.data.tutors.toList()..addAll(right.rows),
          count: right.count,
          page: right.currentPage,
        )),
      );
    });
  }

  void markFavorite(String id, bool isFavorite) async {
    final response = await tutorUseCase.markFavoriteTutor(id: id);
    if (response) {
      logger.d(response);
      state.data.tutors
          .firstWhere((element) => element.userId.compareTo(id) == 0)
          .favoriteController
          .add(isFavorite);
    }
  }

  void refreshTutor() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }

  void searchTutor() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }

  void filterTutor() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }

  void sortTutor() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }

  void loadTutorDetail() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }
}
