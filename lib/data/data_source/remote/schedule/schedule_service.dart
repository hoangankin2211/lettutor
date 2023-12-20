import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'schedule_service.g.dart';

@injectable
@RestApi()
abstract class ScheduleService {
  static const String branch = "/booking";
  static const String getScheduleListUrl = '$branch/list/student';
  static const String getNextAppointmentUrl = '$branch/next';
  static const String getTutorSchedule = "/schedule";
  static const String studentRequest = 'student-request/{bookedId}';

  @factoryMethod
  factory ScheduleService(Dio dio) = _ScheduleService;

  @POST(getTutorSchedule)
  Future<HttpResponse> getOwnScheduleList();

  @GET(
      '$getTutorSchedule?tutorId={tutorId}&startTimestamp={sT}&endTimestamp={eT}')
  Future<HttpResponse> getScheduleByTutor(
    @Path('tutorId') String tutorId,
    @Path('sT') int st,
    @Path('eT') int et,
  );

  @GET(getScheduleListUrl)
  Future<HttpResponse> getScheduleListForStudent(
      {@Queries() required Map<String, dynamic> queries});

  @POST(branch)
  Future<HttpResponse> bookClass({@Body() required Map<String, dynamic> body});

  @DELETE(branch)
  Future<HttpResponse> cancelScheduleClass(
      {@Body() required Map<String, dynamic> body});

  @POST("$branch/$studentRequest")
  Future<HttpResponse> updateStudentRequest({
    @Path("bookedId") required String id,
    @Body() required Map<String, dynamic> body,
  });

  @GET("$getNextAppointmentUrl?dateTime={time}")
  Future<HttpResponse> getNextAppointment({@Path("time") required int time});
}
