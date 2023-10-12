// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'package:lettutor/data/entities/tutor/tutor_detail_entity.dart';

import '../../../entities/response/schedule_response.dart';
import '../../../entities/response/search_tutor_response.dart';
import '../../../entities/response/tutor_response.dart';

part 'tutor_service.g.dart';

@injectable
@RestApi()
abstract class TutorService {
  static const String branch = "/tutor";
  static const String fetchTutorial = "$branch/more";
  static const String searchTutorApi = "$branch/search";
  static const String getTutorByIdApi = branch;
  static const String markFavorite = "/user/manageFavoriteTutor";

  @factoryMethod
  factory TutorService(Dio dio) = _TutorService;

  @GET('$fetchTutorial?perPage={size}&page={page}')
  Future<HttpResponse<TutorResponse>> fetchTutorialPage({
    @Path('page') required int page,
    @Path("size") required int size,
  });

  @POST(markFavorite)
  Future<HttpResponse> addTutorToFavorite(
      {@Body() required Map<String, dynamic> body});

  @POST(searchTutorApi)
  Future<HttpResponse<SearchTutorResponse>> searchTutor(
      {@Body() required Map<String, dynamic> body});

  @GET('$getTutorByIdApi/{id}')
  Future<HttpResponse<TutorDetailEntity>> getTutorById(
    @Path('id') String id,
  );
}
