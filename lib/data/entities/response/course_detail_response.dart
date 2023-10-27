import 'package:lettutor/data/entities/course/course_detail_entity.dart';

class CourseDetailResponse {
  final String message;
  final CourseDetailEntity? data;

  const CourseDetailResponse(this.message, this.data);

  static CourseDetailResponse fromJson(Map<String, dynamic> data) {
    if (data['data'] == null) return const CourseDetailResponse("Failed", null);
    return CourseDetailResponse(
      data['message'],
      CourseDetailEntity.fromJson(data['data']),
    );
  }
}
