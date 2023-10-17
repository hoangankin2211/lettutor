import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/entities/feedback/feedback_entity.dart';
import 'package:lettutor/domain/models/tutor/tutor_detail.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_detail_state.dart';

@injectable
class TutorDetailBloc extends Cubit<TutorDetailState> {
  final TutorUseCase tutorUseCase;

  TutorDetailBloc(this.tutorUseCase)
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

  void fetchTutorFeedbackData() {}
}
