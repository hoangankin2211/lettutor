import 'package:either_dart/either.dart';
import 'package:lettutor/data/entities/feedback/feedback_entity.dart';
import 'package:lettutor/data/entities/request/tutor_search_request.dart';
import 'package:lettutor/data/entities/response/feedback_response.dart';
import 'package:lettutor/data/entities/response/search_tutor_response.dart';
import 'package:lettutor/data/entities/response/tutor_response.dart';
import 'package:lettutor/data/entities/schedule/schedule_entity.dart';
import 'package:lettutor/data/entities/tutor/tutor_detail_entity.dart';

abstract class TutorRepository {
  Future<Either<String, TutorResponse>> fetchListTutor(
      {required int perPage, required int page});
  Future<bool> markFavoriteTutor({required String tutorId});
  Future<Either<String, SearchTutorResponse>> searchTutor(
      {required TutorSearchRequest request});
  Future<Either<String, TutorDetailEntity>> getTutorDetail(
      {required String id});
  Future<Either<String, ScheduleEntity>> getTutorSchedule({
    required String id,
    required DateTime startTime,
    required DateTime endTime,
  });
  Future<Either<String, FeedbackResponse>> getTutorFeedbackById(
      {required String id, int perPage = 10, int page = 1});
}
