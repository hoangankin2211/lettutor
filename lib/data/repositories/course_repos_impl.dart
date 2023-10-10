// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/components/networking/data_state.dart';

import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/course/course_service.dart';
import 'package:lettutor/data/entities/course/course_category_entity.dart';
import 'package:lettutor/data/entities/course/course_detail_entity.dart';
import 'package:lettutor/data/entities/course/course_entity.dart';
import 'package:lettutor/data/entities/response/content_category_response.dart';
import 'package:lettutor/data/entities/response/course_detail_response.dart';
import 'package:lettutor/data/entities/response/course_response.dart';
import 'package:lettutor/domain/mapper/course_mapper.dart';
import 'package:lettutor/domain/models/course_category.dart';
import 'package:lettutor/domain/repositories/course_repo.dart';

@Injectable(as: CourseRepository)
class CourseRepositoryImpl extends CourseRepository {
  final CourseService courseService;

  CourseRepositoryImpl({
    required this.courseService,
  });

  @override
  Future<Either<String, CourseResponse>> fetchCoursePage(
      {required int page,
      required int perPge,
      String? q,
      String? categoryId}) async {
    final dataState = await getStateOf<CourseResponse>(
      request: () async => courseService.fetchCoursePage(queries: {
        "page": page,
        "per_page": perPge,
        "q": q,
        "category_id": categoryId,
      }),
    );

    if (dataState is DataSuccess) {
      return Right(dataState.data!);
    }
    return Left(dataState.dioException?.message ?? "Error while fetching");
  }

  @override
  Future<Either<String, List<CourseCategoryEntity>>> getCourseCategory() async {
    final dataState = await getStateOf<ContentCategoryResponse>(
      request: () async => courseService.getCategoryContent(),
    );

    if (dataState is DataSuccess) {
      return Right(dataState.data!.rows);
    }
    return Left(dataState.dioException?.message ?? "Error while fetching");
  }

  @override
  Future<Either<String, CourseDetailEntity>> getCourseDetail(
      {required String id}) async {
    final dataState = await getStateOf<CourseDetailResponse>(
      request: () async => courseService.getCourseDetail(id: id),
    );

    if (dataState is DataSuccess && dataState.data!.data != null) {
      return Right(dataState.data!.data!);
    }
    return Left(dataState.dioException?.message ?? "Error while fetching");
  }
}
