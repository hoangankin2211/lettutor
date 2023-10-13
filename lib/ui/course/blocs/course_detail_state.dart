// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'course_detail_bloc.dart';

class CourseDetailState {
  final CourseDetail? course;
  CourseDetailState({
    required this.course,
  });

  CourseDetailState copyWith({
    CourseDetail? course,
  }) {
    return CourseDetailState(
      course: course ?? this.course,
    );
  }
}

class InitialCourseDetailPage extends CourseDetailState {
  InitialCourseDetailPage() : super(course: null);
}

class LoadingCourseDetail extends CourseDetailState {
  LoadingCourseDetail({required CourseDetail? data}) : super(course: data);
}

class LoadCourseDetailSuccess extends CourseDetailState {
  LoadCourseDetailSuccess({required CourseDetail data}) : super(course: data);
}

class ErrorCourseDetail extends CourseDetailState {
  final String message;
  ErrorCourseDetail({required this.message, required CourseDetail? data})
      : super(course: data);
}
