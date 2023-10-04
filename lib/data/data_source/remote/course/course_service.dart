import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'course_service.g.dart';

@injectable
@RestApi()
abstract class CourseService {
  static const String course = "/course";
  static const String contentCategory = "/content-category";

  @factoryMethod
  factory CourseService(Dio dio) = _CourseService;

  @GET(course)
  Future<HttpResponse<dynamic>> fetchCoursePage(
      {@Queries() required Map<String, dynamic> queries});

  @GET("$course/{id}")
  Future<HttpResponse<dynamic>> getCourseDetail(
      {@Path("id") required String id});

  @GET(contentCategory)
  Future<HttpResponse<dynamic>> getCategoryContent();
}
