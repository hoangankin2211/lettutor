import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';

import '../../../domain/models/tutor/tutor.dart';

part 'tutor_state.dart';

@injectable
class TutorBloc extends Cubit<TutorState> {
  final TutorUseCase tutorUseCase;
  TutorBloc(this.tutorUseCase)
      : super(const TutorInitial(
            data: TutorDataState(page: 0, count: 0, tutors: [])));

  void loadTutor() async {
    emit(TutorLoading(data: state.data));
    final response = await tutorUseCase.fetchTutorPage(page: 1, perPage: 10);
    response.fold((left) {
      emit(TutorError(data: state.data, message: left));
    }, (right) {
      emit(
        TutorLoaded(
            data: state.data.copyWith(
          tutors: right.rows,
          count: right.count,
          page: right.currentPage,
        )),
      );
    });
  }

  void loadMoreTutor() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }

  void refreshTutor() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }

  void searchTutor() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }

  void filterTutor() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }

  void sortTutor() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }

  void loadTutorDetail() {
    emit(TutorLoading(data: state.data));
    emit(TutorLoaded(data: state.data));
  }
}
