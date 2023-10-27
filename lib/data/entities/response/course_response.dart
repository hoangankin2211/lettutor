import '../course/course_entity.dart';

class CourseResponse {
  final String status;
  final int count;
  final List<CourseEntity> courses;
  CourseResponse(this.status, this.count, this.courses);

  static CourseResponse fromJson(Map<String, dynamic> data) {
    final cData = data['data'];
    if (cData == null) return CourseResponse('Error', 0, List.empty());
    return CourseResponse(
      data['message']?.toString() ?? 'Error',
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => CourseEntity.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}
