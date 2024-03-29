import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/data/entities/request/tutor_search_request.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/data/entities/schedule/schedule_entity.dart';
import 'package:lettutor/domain/usecases/schedule_usecase.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';

import '../../../domain/models/tutor/tutor.dart';

part 'tutor_state.dart';

@injectable
class TutorBloc extends Cubit<TutorState> {
  final TutorUseCase tutorUseCase;
  final ScheduleUseCase scheduleUseCase;

  TutorBloc(this.tutorUseCase, this.scheduleUseCase)
      : super(const TutorInitial(data: TutorDataState()));

  int cacheCount = 0;

  Future<void> loadTutor({
    int page = 1,
    int perPage = 10,
  }) async {
    emit(TutorLoading(data: state.data));

    final response = await tutorUseCase.searchTutorByFilter(
      TutorSearchRequest(page: page, perPage: perPage),
    );

    final totalLearnTime = await tutorUseCase.getTotalTime();

    logger.d(totalLearnTime);

    response.fold((left) {
      emit(TutorError(data: state.data, message: left));
    }, (right) async {
      emit(
        TutorLoaded(
            data: state.data.copyWith(
          tutors: right.rows,
          count: right.count,
          totalLearnTime: totalLearnTime,
          page: right.currentPage,
        )),
      );
    });
  }

  void loadMoreTutor({
    required int page,
    int perPage = 10,
  }) async {
    if (state.data.page > state.data.totalPage) {
      return;
    }

    final response = await tutorUseCase.searchTutorByFilter(
      TutorSearchRequest(page: page, perPage: perPage),
    );

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
      emit(
        TutorLoaded(
          data: state.data.copyWith(
            tutors: state.data.tutors
                .map((e) =>
                    e.userId == id ? e.copyWith(isFavorite: isFavorite) : e)
                .toList(),
          ),
        ),
      );
    }
  }

  void refreshTutor() {
    emit(TutorLoading(data: state.data));
  }

  Future<void> fetchUpcomingClass() async {
    if (state is TutorError) {
      return;
    }

    scheduleUseCase.getNextAppointment(DateTime.now()).then(
          (value) => value.fold(
            (left) {},
            (right) async {
              final totalLearnTime = await tutorUseCase.getTotalTime();
              emit(
                TutorLoaded(
                  data: state.data.copyWith(
                    nextTutor: right,
                    totalLearnTime: totalLearnTime,
                  ),
                ),
              );
            },
          ),
        );
  }

  Future<void> searchTutor(
      {TutorSearchRequest filter = const TutorSearchRequest()}) async {
    emit(TutorLoading(data: state.data));
    tutorUseCase.searchTutorByFilter(filter).then(
          (value) => value.fold(
            (left) => emit(TutorError(data: state.data, message: left)),
            (right) {
              emit(
                TutorLoaded(
                  data: state.data.copyWith(
                    tutors: right.rows,
                    count: right.count,
                    page: right.currentPage,
                    filter: filter,
                  ),
                ),
              );
            },
          ),
        );
  }
}
