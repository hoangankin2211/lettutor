import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/entities/feedback/feedback_entity.dart';
import 'package:lettutor/domain/models/tutor/tutor_detail.dart';
import 'package:lettutor/domain/usecases/schedule_usecase.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_detail_state.dart';

@injectable
class TutorDetailBloc extends Cubit<TutorDetailState> {
  final TutorUseCase tutorUseCase;
  final ScheduleUseCase scheduleUseCase;

  TutorDetailBloc(this.tutorUseCase, this.scheduleUseCase)
      : super(TutorDetailInitial(data: TutorDetailDataState()));

  void fetchTutorDetailData(String id) async {
    emit(TutorDetailLoading(data: state.data));

    final result = await Future.wait([
      tutorUseCase.getTutorById(tutorId: id),
      tutorUseCase.getFeedbackById(userId: id)
    ]);
    var data = state.data;
    for (var element in result) {
      if (element.isLeft) {
        emit(TutorDetailError(data: state.data, message: element.left));
        return;
      } else {
        if (element.right is List<FeedbackEntity>) {
          data =
              data.copyWith(feedbacks: element.right as List<FeedbackEntity>);
        } else {
          data = data.copyWith(tutorDetail: element.right as TutorDetail);
        }
      }
    }
    emit(TutorDetailLoaded(data: data));
  }

  void getTutorFreeBooking(DateTime from, DateTime to,
      {bool isFetching = false}) {
    emit(LoadingFreeBooking(data: state.data, isFetching: isFetching));
    scheduleUseCase
        .getScheduleByTutorId(
          tutorId: state.data.tutorDetail.user!.id,
          from: from,
          to: to,
        )
        .then(
          (value) => value.fold(
            (left) => emit(ErrorFreeBooking(data: state.data, message: left)),
            (right) => emit(LoadedFreeBooking(
                data: state.data.copyWith(bookingTime: right))),
          ),
        );
  }

  Future<bool> bookTutor({
    required String scheduleId,
    required List<String> scheduleDetailIds,
    String note = "",
  }) async {
    emit(BookingClass(data: state.data, scheduleId: scheduleId));
    return await scheduleUseCase
        .bookClassById(scheduleIds: scheduleDetailIds, studentNote: note)
        .then(
          (value) => value.fold(
            (left) {
              emit(BookClassFailed(
                message: left,
                data: state.data,
                scheduleId: scheduleId,
              ));
              return false;
            },
            (right) {
              emit(BookClassSuccess(
                  data: state.data.copyWith(
                    bookingTime: state.data.bookingTime
                        .map((e) =>
                            e.id == scheduleId ? e.copyWith(isBooked: true) : e)
                        .toList(),
                  ),
                  scheduleId: scheduleId));
              return true;
            },
          ),
        );
  }

  void fetchTutorFeedbackData() {}
}
