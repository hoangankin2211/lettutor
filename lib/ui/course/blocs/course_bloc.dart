import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/domain/models/course_detail.dart';
import 'package:lettutor/domain/usecases/course_usecase.dart';

part 'course_event.dart';
part 'course_state.dart';

@injectable
class CourseBloc extends Cubit<CourseState> {
  final CourseUseCase courseUseCase;

  CourseBloc(this.courseUseCase) : super(InitialCourseListPage());

  void fetchCourseList({
    required int page,
  }) {
    emit(LoadingListCourse(data: state.data));

    courseUseCase.fetchListCourse(page: page, size: 10).then(
          (value) => value.fold(
            (l) => emit(ErrorCourseList(message: l, data: state.data)),
            (r) => emit(LoadListCourseSuccess(
              data: state.data.copyWith(
                course: r.rows,
                page: page,
                count: r.count,
              ),
            )),
          ),
        );
  }

  void openCourseDetail({required String id}) {}
}
