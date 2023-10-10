part of 'course_bloc.dart';

abstract class CourseEvent {}

class FetchCoursePage extends CourseEvent {
  final Map<String, dynamic> queries;

  FetchCoursePage({required this.queries});
}

class GetCourseDetail extends CourseEvent {
  final String id;

  GetCourseDetail({required this.id});
}
