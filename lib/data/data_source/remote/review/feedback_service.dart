import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'feedback_service.g.dart';

@injectable
@RestApi()
abstract class FeedbackService {
  static const String getReviewApi = "/feedback/v2";
  static const String addFeedbackTutor = "/user/feedbackTutor";

  @factoryMethod
  factory FeedbackService(Dio dio) = _FeedbackService;

  @GET('$getReviewApi/{id}')
  Future<HttpResponse> getReviews(
    @Path('id') String id, {
    @Body() required Map<String, dynamic> body,
  });

  @POST(addFeedbackTutor)
  Future<HttpResponse<dynamic>> addFeedBack(
      {@Body() required Map<String, dynamic> body});
}
