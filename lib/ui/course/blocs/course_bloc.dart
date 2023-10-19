import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/domain/models/course/course.dart';
import 'package:lettutor/domain/usecases/course_usecase.dart';

part 'course_state.dart';

@injectable
class CourseBloc extends Cubit<CourseState> {
  final CourseUseCase courseUseCase;

  CourseBloc(this.courseUseCase) : super(InitialCourseListPage());

  final List<CourseDetail> cacheListCourse = [];
  int cacheCount = 0;

  Future<void> fetchCourseList({
    int page = 1,
    int perPage = 10,
    String? q,
    String? categoryId,
    bool isFilter = false,
    bool isInitState = false,
  }) async {
    emit(LoadingListCourse(data: state.data));

    courseUseCase
        .fetchListCourse(
      page: page,
      size: perPage,
    )
        .then((value) {
      if (!isClosed) {
        value.fold(
          (l) => emit(ErrorCourseList(message: l, data: state.data)),
          (r) {
            final listCourse = List.of(state.data.course, growable: true)
              ..addAll(r.rows);
            cacheCount = r.count;

            cacheListCourse
              ..clear()
              ..addAll(listCourse);
            emit(LoadListCourseSuccess(
              data: state.data.copyWith(
                categoryId: null,
                perPage: 10,
                q: null,
                course: r.rows,
                page: page,
                count: r.count,
              ),
            ));
          },
        );
      }
    });
  }

  void searchCourse(
      {String? q,
      String? categoryId,
      bool isFilter = false,
      bool isInitState = false}) {
    emit(LoadingListCourse(data: state.data));

    if (q?.isEmpty ?? true) {
      return emit(LoadListCourseSuccess(
        data: state.data.copyWith(
          course: cacheListCourse.take(10).toList(),
          categoryId: null,
          q: null,
          perPage: 10,
          page: 1,
          count: cacheCount,
        ),
      ));
    }

    courseUseCase
        .fetchListCourse(
      page: 1,
      size: 10,
      categoryId: categoryId,
      q: q,
    )
        .then((value) {
      if (!isClosed) {
        value.fold(
          (l) => emit(ErrorCourseList(message: l, data: state.data)),
          (r) {
            emit(LoadListCourseSuccess(
              data: state.data.copyWith(
                course: r.rows,
                categoryId: categoryId,
                q: q,
                perPage: 10,
                page: 1,
                count: r.count,
              ),
            ));
          },
        );
      }
    });
  }

  void refreshCourse() {}

  void loadMoreCourse({
    int? page,
    int? perPage,
    String? q,
    String? categoryId,
  }) {
    if (page != null && page > state.data.totalPage) {
      return;
    }

    courseUseCase
        .fetchListCourse(
      page: page ?? state.data.page,
      size: perPage ?? state.data.perPage,
      categoryId: categoryId ?? state.data.categoryId,
      q: q ?? state.data.q,
    )
        .then((value) {
      if (!isClosed) {
        value.fold(
          (l) => emit(ErrorCourseList(message: l, data: state.data)),
          (r) {
            final listCourse = List.of(state.data.course, growable: true)
              ..addAll(r.rows);

            cacheListCourse
              ..clear()
              ..addAll(listCourse);
            emit(LoadListCourseSuccess(
              data: state.data.copyWith(
                course: listCourse,
                page: page ?? state.data.page,
                count: r.count,
              ),
            ));
          },
        );
      }
    });
  }

  void openCourseDetail({required String id}) {}
}
