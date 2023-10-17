part of 'tutor_bloc.dart';

class TutorDataState {
  final int page;
  final int count;
  final List<Tutor> tutors;

  const TutorDataState({
    required this.page,
    required this.count,
    required this.tutors,
  });

  TutorDataState copyWith({int? page, int? count, List<Tutor>? tutors}) {
    return TutorDataState(
      page: page ?? this.page,
      count: count ?? this.count,
      tutors: tutors ?? this.tutors,
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
