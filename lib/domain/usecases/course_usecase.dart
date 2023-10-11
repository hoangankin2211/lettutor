import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/domain/mapper/course_mapper.dart';
import 'package:lettutor/domain/models/course_detail.dart';
import 'package:lettutor/domain/models/pagination.dart';
import 'package:lettutor/domain/repositories/course_repo.dart';

import '../models/course_category.dart';

@injectable
class CourseUseCase {
  final CourseRepository courseRepository;

  CourseUseCase(this.courseRepository);

  Future<Either<String, Pagination<CourseDetail>>> fetchListCourse({
    required int page,
    required int size,
    String? q,
    String? categoryId,
  }) async =>
      courseRepository
          .fetchCoursePage(
              page: page, perPge: size, q: q, categoryId: categoryId)
          .either(
            (left) => left,
            (right) => Pagination(
              count: right.count,
              currentPage: page,
              rows: right.courses
                  .map(CourseMapper.courseEntityFromEntity)
                  .toList(),
            ),
          );

  Future<Either<String, List<CourseCategory>>> getCourseCategory() =>
      courseRepository.getCourseCategory().mapRight(
            (right) =>
                right.map(CourseMapper.courseCategoryFromEntity).toList(),
          );

  Future<Either<String, CourseDetail>> getCourseDetail(String id) {
    return courseRepository
        .getCourseDetail(id: id)
        .mapRight(CourseMapper.courseDetailEntityFromEntity);
  }
}
