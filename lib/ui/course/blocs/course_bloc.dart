import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/domain/models/course/course.dart';
import 'package:lettutor/domain/usecases/course_usecase.dart';

part 'course_state.dart';

@injectable
class CourseBloc extends Cubit<CourseState> {
  final CourseUseCase courseUseCase;

  CourseBloc(this.courseUseCase) : super(InitialCourseListPage());

  void fetchCourseList({
    int page = 1,
    int perPage = 10,
  }) {
    emit(LoadingListCourse(data: state.data));

    courseUseCase.fetchListCourse(page: page, size: perPage).then((value) {
      if (!isClosed) {
        value.fold(
          (l) => emit(ErrorCourseList(message: l, data: state.data)),
          (r) => emit(LoadListCourseSuccess(
            data: state.data.copyWith(
              course: state.data.course.toList()..addAll(r.rows),
              page: page,
              count: r.count,
            ),
          )),
        );
      }
    });
  }

  void openCourseDetail({required String id}) {}
}
