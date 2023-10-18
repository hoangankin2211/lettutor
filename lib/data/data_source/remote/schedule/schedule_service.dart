import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/entities/response/booking_info_response.dart';
import 'package:lettutor/data/entities/response/upcoming_class_response.dart';
import 'package:lettutor/data/entities/schedule/schedule_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../../entities/response/schedule_response.dart';

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
  Future<HttpResponse<ScheduleEntity>> getOwnScheduleList();

  @POST('$getTutorSchedule?tutorId={tutorId}')
  Future<HttpResponse<ScheduleResponse>> getScheduleByTutor(
    @Path('tutorId') String tutorId,
    // @Path('sT') int st,
    // @Path('eT') int et,
  );

  @GET(getScheduleListUrl)
  Future<HttpResponse<BookingResponse>> getScheduleListForStudent(
      {@Queries() required Map<String, dynamic> queries});

  @POST(branch)
  Future<HttpResponse> bookClass({@Body() required Map<String, dynamic> body});

  @DELETE(branch)
  Future<HttpResponse> cancelScheduleClass(
      {@Body() required Map<String, dynamic> body});

  @POST(branch)
  Future<HttpResponse> updateStudentRequest(
      {@Path("bookedId") required String id});

  @GET("$getNextAppointmentUrl?dateTime={time}")
  Future<HttpResponse<UpcomingClassResponse>> getNextAppointment(
      {@Path("time") required int time});
}
