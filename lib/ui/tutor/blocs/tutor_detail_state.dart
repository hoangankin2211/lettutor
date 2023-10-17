// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lettutor/data/entities/feedback/feedback_entity.dart';
import 'package:lettutor/domain/models/tutor/tutor_detail.dart';

class TutorDetailDataState {
  final TutorDetail tutorDetail;
  final List<FeedbackEntity> feedbacks;

  TutorDetailDataState({
    this.tutorDetail = const TutorDetail(),
    this.feedbacks = const [],
  });

  TutorDetailDataState copyWith({
    TutorDetail? tutorDetail,
    List<FeedbackEntity>? feedbacks,
  }) {
    return TutorDetailDataState(
      tutorDetail: tutorDetail ?? this.tutorDetail,
      feedbacks: feedbacks ?? this.feedbacks,
    );
  }
}

abstract class TutorDetailState {
  final TutorDetailDataState data;

  TutorDetailState({required this.data});
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
