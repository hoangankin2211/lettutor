import 'package:either_dart/either.dart';
import 'package:lettutor/data/entities/course/course_category_entity.dart';
import 'package:lettutor/data/entities/course/course_detail_entity.dart';
import 'package:lettutor/data/entities/course/course_entity.dart';

import '../../data/entities/response/course_response.dart';

abstract class CourseRepository {
  Future<Either<String, CourseResponse>> fetchCoursePage(
      {required int page, required int perPge, String? q, String? categoryId});
  Future<Either<String, CourseDetailEntity>> getCourseDetail(
      {required String id});
  Future<Either<String, List<CourseCategoryEntity>>> getCourseCategory();
}
