import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/components/networking/data_state.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/ebook/ebook_service.dart';
import 'package:lettutor/data/entities/response/ebook_response.dart';
import 'package:lettutor/domain/mapper/course_mapper.dart';
import 'package:lettutor/domain/models/course/course.dart';
import 'package:lettutor/domain/models/pagination.dart';
import 'package:lettutor/domain/repositories/course_repo.dart';

@injectable
class CourseUseCase {
  final CourseRepository courseRepository;
  final EbookService ebookService;

  CourseUseCase(this.courseRepository, this.ebookService);

  Future<Either<String, Pagination<CourseDetail>>> fetchListCourse({
    required int page,
    required int size,
    String? q,
    String? categoryId,
  }) async =>
      courseRepository
          .fetchCoursePage(
            page: page,
            perPge: size,
            q: q,
            categoryId: categoryId,
          )
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

  Future<Either<String, EBookResponse>> getEBookList({
    required int page,
    required int size,
    String? q,
    String? categoryId,
  }) async {
    final queries = <String, dynamic>{"page": page, "size": size};
    if (q?.isNotEmpty ?? false) {
      queries.addAll({"q": q});
    }
    if (categoryId?.isNotEmpty ?? false) {
      queries.addAll({"categoryId": categoryId});
    }
    final response = await getStateOf<EBookResponse>(
        request: () => ebookService.getEbook(queries: queries));
    if (response is DataSuccess && response.data != null) {
      return Right(response.data!);
    }
    return const Left("Error getting ebook list");
  }
}
