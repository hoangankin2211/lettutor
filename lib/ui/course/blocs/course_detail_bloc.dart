import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/domain/usecases/course_usecase.dart';
import 'package:lettutor/ui/course/blocs/course_detail_state.dart';

@injectable
class CourseDetailBloc extends Cubit<CourseDetailState> {
  final CourseUseCase courseUseCase;

  CourseDetailBloc(this.courseUseCase) : super(InitialCourseDetailPage());

  void fetchCourseDetailData(String id) {
    emit(LoadingCourseDetail(data: state.course));

    courseUseCase.getCourseDetail(id).then((value) {
      if (isClosed) {
        value.fold(
          (l) => emit(ErrorCourseDetail(message: l, data: state.course)),
          (r) => emit(LoadCourseDetailSuccess(data: r)),
        );
      }
    });
  }
}
