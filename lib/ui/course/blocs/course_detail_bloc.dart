import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/analytics/google_analytic_service.dart';
import 'package:lettutor/domain/models/course/course.dart';
import 'package:lettutor/domain/usecases/course_usecase.dart';
part 'course_detail_state.dart';

@injectable
class CourseDetailBloc extends Cubit<CourseDetailState> {
  final CourseUseCase courseUseCase;
  final GoogleAnalyticService analyticService;

  CourseDetailBloc(this.courseUseCase, this.analyticService)
      : super(InitialCourseDetailPage());

  void fetchCourseDetailData(String id) {
    emit(LoadingCourseDetail(data: state.course));

    courseUseCase.getCourseDetail(id).then((value) {
      if (!isClosed) {
        value.fold(
          (l) => emit(ErrorCourseDetail(message: l, data: state.course)),
          (r) {
            // analyticService.sendEvent(AnalyticEvent.openCourse.name, {
            //   "course_id": id,
            //   "course_name": r.name,
            // });
            emit(LoadCourseDetailSuccess(data: r));
          },
        );
      }
    });
  }

  void rebuildBloc() => emit(state.copyWith());
}
