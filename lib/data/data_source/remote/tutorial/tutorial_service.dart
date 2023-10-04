import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'tutorial_service.g.dart';

@injectable
@RestApi()
abstract class TutorialService {
  static const String branch = "/tutor";
  static const String fetchTutorial = "$branch/more";
  static const String searchTutor = "$branch/search";
  static const String getTutorById = branch;
  static const String getTutorSchedule = "/schedule";
  static const String markFavorite = "/user/manageFavoriteTutor";

  @factoryMethod
  factory TutorialService(Dio dio) = _TutorialService;

  @GET('$fetchTutorial?perPage={size}&page={page}')
  Future<HttpResponse<dynamic>> fetchTutorialPage({
    @Path('page') required int page,
    @Path("size") required int size,
  });
}
