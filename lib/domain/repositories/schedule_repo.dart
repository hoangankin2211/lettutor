import 'package:either_dart/either.dart';
import 'package:lettutor/data/entities/response/booking_info_response.dart';
import 'package:lettutor/data/entities/response/upcoming_class_response.dart';

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
}
