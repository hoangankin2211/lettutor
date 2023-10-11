import 'package:lettutor/domain/models/course_detail.dart';

abstract class CourseDetailState {
  final CourseDetail? course;
  CourseDetailState({
    required this.course,
  });
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
