import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'schedule_service.g.dart';

@injectable
@RestApi()
abstract class ScheduleService {
  static const String branch = "/booking";
  static const String getScheduleListUrl = '$branch/list/student';
  static const String getNextAppointmentUrl = '$branch/next';

  @factoryMethod
  factory ScheduleService(Dio dio) = _ScheduleService;

  @GET(getScheduleListUrl)
  Future<HttpResponse<dynamic>> getScheduleList(
      {@Queries() required Map<String, dynamic> queries});

  @GET("$getNextAppointmentUrl?dateTime={time}")
  Future<HttpResponse<dynamic>> getNextAppointment(
      {@Path("time") required int time});
}
