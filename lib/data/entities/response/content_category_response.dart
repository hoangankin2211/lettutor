import '../course/course_category_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContentCategoryResponse {
  final int count;
  final List<CourseCategoryEntity> rows;
  ContentCategoryResponse(this.count, this.rows);
  static ContentCategoryResponse fromJson(Map<String, dynamic> data) {
    return ContentCategoryResponse(
      (data['count'] as int?) ?? 0,
      data['rows'] != null
          ? ((data['rows']) as List<dynamic>)
              .map((e) => CourseCategoryEntity.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}
