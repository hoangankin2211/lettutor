import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
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
  }) async {
    emit(ScheduleLoading(data: state.data));
    (await scheduleUseCase.getListBooking(
      page: page,
      perPage: perPage,
      dateTime: DateTime.now().subtract(const Duration(days: 15)),
      isHistoryGet: false,
    ))
        .fold(
            (left) => emit(ScheduleError(data: state.data, message: left)),
            (right) => emit(ScheduleLoaded(
                  data: state.data.copyWith(
                    count: right.count,
                    page: right.currentPage,
                    perPage: right.perPage,
                    schedules: right.rows,
                  ),
                )));
  }

  Future<void> loadMoreSchedule() async {
    if (state.data.page < state.data.totalPage) {
      await fetchScheduleList(page: state.data.page + 1);
    }
  }
}
