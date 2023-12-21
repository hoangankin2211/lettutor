// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lettutor/data/entities/feedback/feedback_entity.dart';
import 'package:lettutor/data/entities/schedule/schedule_entity.dart';
import 'package:lettutor/domain/models/tutor/tutor_detail.dart';

class TutorDetailDataState {
  final TutorDetail tutorDetail;
  final List<FeedbackEntity> feedbacks;
  final List<ScheduleEntity> bookingTime;

  TutorDetailDataState({
    this.bookingTime = const [],
    this.tutorDetail = const TutorDetail(),
    this.feedbacks = const [],
  });

  TutorDetailDataState copyWith({
    TutorDetail? tutorDetail,
    List<ScheduleEntity>? bookingTime,
    List<FeedbackEntity>? feedbacks,
  }) {
    return TutorDetailDataState(
      tutorDetail: tutorDetail ?? this.tutorDetail,
      feedbacks: feedbacks ?? this.feedbacks,
      bookingTime: bookingTime ?? this.bookingTime,
    );
  }
}

abstract class TutorDetailState {
  final TutorDetailDataState data;
  final bool isMainState;
  TutorDetailState({
    required this.data,
    this.isMainState = true,
  });

  bool isBooking(String scheduleId) =>
      this is BookingClass && scheduleId == (this as BookingClass).scheduleId;

  bool isFetchingList() =>
      this is LoadingFreeBooking && (this as LoadingFreeBooking).isFetching;
}

class TutorDetailInitial extends TutorDetailState {
  TutorDetailInitial({required TutorDetailDataState data}) : super(data: data);
}

class TutorDetailLoading extends TutorDetailState {
  TutorDetailLoading({required TutorDetailDataState data}) : super(data: data);
}

class TutorDetailLoaded extends TutorDetailState {
  TutorDetailLoaded({required TutorDetailDataState data}) : super(data: data);
}

class TutorDetailError extends TutorDetailState {
  final String message;

  TutorDetailError({required TutorDetailDataState data, required this.message})
      : super(data: data);
}

class LoadingFreeBooking extends TutorDetailState {
  final bool isFetching;
  LoadingFreeBooking({required super.data, this.isFetching = false})
      : super(isMainState: false);
}

class LoadedFreeBooking extends TutorDetailState {
  LoadedFreeBooking({required super.data}) : super(isMainState: false);
}

class ErrorFreeBooking extends TutorDetailState {
  final String message;

  ErrorFreeBooking({required super.data, required this.message})
      : super(isMainState: false);
}

class BookClass extends TutorDetailState {
  final String scheduleId;
  BookClass({required super.data, required this.scheduleId})
      : super(isMainState: false);
}

class BookingClass extends BookClass {
  BookingClass({required super.data, required super.scheduleId});
}

class BookClassSuccess extends BookClass {
  BookClassSuccess({required super.data, required super.scheduleId});
}

class BookClassFailed extends BookClass {
  final String message;
  BookClassFailed({
    required this.message,
    required super.data,
    required super.scheduleId,
  });
}
