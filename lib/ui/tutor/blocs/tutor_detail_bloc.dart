import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/analytics/google_analytic_service.dart';
import 'package:lettutor/data/data_source/remote/tutorial/tutor_service.dart';
import 'package:lettutor/data/entities/feedback/feedback_entity.dart';
import 'package:lettutor/domain/models/tutor/tutor_detail.dart';
import 'package:lettutor/domain/usecases/schedule_usecase.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_detail_state.dart';

@injectable
class TutorDetailBloc extends Cubit<TutorDetailState> {
  final TutorUseCase tutorUseCase;
  final TutorService tutorService;
  final ScheduleUseCase scheduleUseCase;
  final GoogleAnalyticService analyticService;

  TutorDetailBloc(this.tutorUseCase, this.scheduleUseCase, this.tutorService,
      this.analyticService)
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
        // analyticService.sendEvent(AnalyticEvent.openTutorDetail.name, {
        //   "tutor_id": id,
        //   "tutor_name": (element.right as TutorDetail).user!.name,
        // });

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

  void markFavorite(bool isFavorite) async {
    final response = await tutorUseCase.markFavoriteTutor(
        id: state.data.tutorDetail.user!.id);
    if (response) {
      emit(
        TutorDetailLoaded(
          data: state.data.copyWith(
            tutorDetail:
                state.data.tutorDetail.copyWith(isFavorite: isFavorite),
          ),
        ),
      );
    }
  }

  Future<void> reportTutor({
    required String tutorId,
    required String content,
  }) async {
    emit(ReportingTutor(data: state.data));
    final response = await tutorService.reportTutor(body: {
      "tutorId": tutorId,
      "content": content,
    });

    if (response.response.statusCode == 200) {
      emit(ReportedTutor(data: state.data));
    } else {
      emit(ReportTutorFailed(data: state.data, message: response.data));
    }
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
              // analyticService.sendEvent(AnalyticEvent.bookTutor.name, {
              //   "tutor_id": state.data.tutorDetail.user!.id,
              //   "tutor_name": state.data.tutorDetail.user!.name,
              //   "schedule_id": scheduleId,
              // });

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
