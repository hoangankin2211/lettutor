// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'tutor_service.g.dart';

@injectable
@RestApi()
abstract class TutorService {
  static const String branch = "/tutor";
  static const String report = "/report";
  static const String fetchTutorial = "$branch/more";
  static const String searchTutorApi = "$branch/search";
  static const String getTutorByIdApi = branch;
  static const String registerTutorApi = "$branch/register";
  static const String getTotalTimeApi = "/call/total";
  static const String markFavorite = "/user/manageFavoriteTutor";

  @factoryMethod
  factory TutorService(Dio dio) = _TutorService;

  @GET('$fetchTutorial?perPage={size}&page={page}')
  Future<HttpResponse> fetchTutorialPage({
    @Path('page') required int page,
    @Path("size") required int size,
  });

  @POST(markFavorite)
  Future<HttpResponse> addTutorToFavorite(
      {@Body() required Map<String, dynamic> body});

  @POST(searchTutorApi)
  Future<HttpResponse> searchTutor(
      {@Body() required Map<String, dynamic> body});

  @GET(getTotalTimeApi)
  Future<HttpResponse> getTotalTime();

  @GET('$getTutorByIdApi/{id}')
  Future<HttpResponse> getTutorById(@Path('id') String id);

  @POST(report)
  Future<HttpResponse> reportTutor(
      {@Body() required Map<String, dynamic> body});

  @POST(registerTutorApi)
  Future<HttpResponse> registerTutor({@Body() required FormData body});
}
