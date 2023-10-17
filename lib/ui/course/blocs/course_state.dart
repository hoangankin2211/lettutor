// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'course_bloc.dart';

class CourseDataState {
  final List<CourseDetail> course;
  final int page;
  final int count;
  final int perPage;
  const CourseDataState({
    this.course = const [],
    this.page = 1,
    this.count = 0,
    this.perPage = 10,
  });

  CourseDataState copyWith({
    List<CourseDetail>? course,
    int? page,
    int? count,
  }) {
    return CourseDataState(
      course: course ?? this.course,
      page: page ?? this.page,
      count: count ?? this.count,
    );
  }
}

abstract class CourseState {
  final CourseDataState data;
  CourseState({required this.data});
}

class InitialCourseListPage extends CourseState {
  InitialCourseListPage() : super(data: const CourseDataState());
}

class LoadingListCourse extends CourseState {
  LoadingListCourse({required super.data});
}

class LoadListCourseSuccess extends CourseState {
  LoadListCourseSuccess({required super.data});
}

class FetchListCourse extends CourseState {
  FetchListCourse({required super.data});
}

class ErrorCourseList extends CourseState {
  final String message;
  ErrorCourseList({required this.message, required super.data});
}
