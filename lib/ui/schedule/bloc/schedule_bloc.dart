import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/domain/usecases/schedule_usecase.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';
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
              ..removeWhere((element) => scheduleId == element.id),
          )),
        ),
      ),
    );
  }
}
