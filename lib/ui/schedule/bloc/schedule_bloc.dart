import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/utils/networking/networking.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/domain/usecases/schedule_usecase.dart';
part 'schedule_state.dart';

@injectable
class ScheduleBloc extends Cubit<ScheduleState> {
  final ScheduleUseCase scheduleUseCase;
  ScheduleBloc(this.scheduleUseCase) : super(ScheduleInitial());

  Future<void> fetchScheduleList({
    int page = 1,
    int perPage = 10,
    bool isHistoryGet = false,
  }) async {
    emit(ScheduleLoading(data: state.data));
    scheduleUseCase
        .getListBooking(
          page: page,
          perPage: perPage,
          dateTime: DateTime.now().subtract(const Duration(days: 15)),
          isHistoryGet: isHistoryGet,
        )
        .then(
          (value) => value.fold(
            (left) => emit(ScheduleError(data: state.data, message: left)),
            (right) => emit(ScheduleLoaded(
                data: state.data.copyWith(
              count: right.count,
              page: right.currentPage,
              perPage: right.perPage,
              schedules: right.rows,
            ))),
          ),
        );
  }

  Future<void> loadMoreSchedule({
    int? page,
    int? perPage,
  }) async {
    if (state.data.page < state.data.totalPage) {
      scheduleUseCase
          .getListBooking(
            page: page ?? state.data.page + 1,
            perPage: perPage ?? state.data.perPage,
            dateTime: DateTime.now().subtract(const Duration(days: 15)),
            isHistoryGet: false,
          )
          .then(
            (value) => value.fold(
              (left) => emit(ScheduleError(data: state.data, message: left)),
              (right) {
                final listCourse = List.of(state.data.schedules, growable: true)
                  ..addAll(right.rows);

                emit(
                  ScheduleLoaded(
                    data: state.data.copyWith(
                      page: right.currentPage,
                      perPage: right.perPage,
                      schedules: listCourse,
                    ),
                  ),
                );
              },
            ),
          );
    }
  }

  Future<void> cancelSchedule(String scheduleId) async {
    emit(CancelingSchedule(data: state.data, scheduleId: scheduleId));
    scheduleUseCase.cancelBookedSchedule(schedulesId: [scheduleId]).then(
      (value) => value.fold(
        (left) => emit(CancelScheduleFailed(data: state.data, message: left)),
        (right) => emit(
          CancelScheduleSuccess(
              data: state.data.copyWith(
            count: state.data.count - 1,
            schedules: state.data.schedules.toList()
              ..removeWhere((element) {
                return scheduleId == element.id;
              }),
          )),
        ),
      ),
    );
  }

  Future<void> editRequest(
      String scheduleId, String bookId, String request) async {
    emit(EditingRequest(data: state.data, scheduleId: scheduleId));
    final result = await scheduleUseCase.editRequest(bookId, request);

    if (result is DataSuccess) {
      final schedule = state.data.schedules
          .firstWhere((element) => element.id == scheduleId);
      logger.d("request: $request");
      schedule.studentRequestController.value = request;
      logger.d(schedule.studentRequestController.value);
      emit(EditRequestSuccess(data: state.data, scheduleId: scheduleId));
    } else {
      emit(ScheduleError(data: state.data, message: result as String));
    }
  }
}
