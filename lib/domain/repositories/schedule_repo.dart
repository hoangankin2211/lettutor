import 'package:either_dart/either.dart';
import 'package:lettutor/data/entities/response/booking_info_response.dart';
import 'package:lettutor/data/entities/response/upcoming_class_response.dart';

import '../../data/entities/response/schedule_response.dart';

abstract class ScheduleRepository {
  Future<Either<String, BookingResponse>> getBookingList({
    required int page,
    required int perPage,
    required DateTime time,
    required bool isHistoryGet,
    String orderBy = 'meeting',
    String sortBy = 'desc',
  });

  Future<Either<String, UpcomingClassResponse>> getNextAppointment(
      {required DateTime dateTime});

  Future<Either<String, bool>> cancelBookedSchedule(
      {required List<String> schedulesId});

  Future<Either<String, ScheduleResponse>> getScheduleByTutorId(
      {required String tutorId, required int from, required int to});
}
