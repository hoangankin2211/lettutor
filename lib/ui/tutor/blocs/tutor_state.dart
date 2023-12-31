part of 'tutor_bloc.dart';

class TutorDataState {
  final int page;
  final int perPage;
  final int count;
  final List<Tutor> tutors;
  final TutorSearchRequest? filter;
  final BookingInfoEntity? nextTutor;
  final int totalLearnTime;

  const TutorDataState({
    this.page = 1,
    this.count = 0,
    this.perPage = 10,
    this.filter,
    this.tutors = const [],
    this.nextTutor,
    this.totalLearnTime = 0,
  });

  int get totalPage => (count.toDouble() / perPage).ceil();

  TutorDataState copyWith(
      {int? perPage,
      int? page,
      int? count,
      List<Tutor>? tutors,
      List<ScheduleEntity>? bookingTime,
      int? totalLearnTime,
      BookingInfoEntity? nextTutor,
      TutorSearchRequest? filter}) {
    return TutorDataState(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      count: count ?? this.count,
      tutors: tutors ?? this.tutors,
      filter: filter ?? this.filter,
      nextTutor: nextTutor ?? this.nextTutor,
      totalLearnTime: totalLearnTime ?? this.totalLearnTime,
    );
  }
}

abstract class TutorState {
  final TutorDataState data;
  const TutorState({required this.data});
}

class TutorInitial extends TutorState {
  const TutorInitial({required super.data});
}

class TutorLoading extends TutorState {
  const TutorLoading({required super.data});
}

class TutorLoaded extends TutorState {
  const TutorLoaded({required super.data});
}

class TutorError extends TutorState {
  final String message;
  const TutorError({
    required this.message,
    required super.data,
  });
}
