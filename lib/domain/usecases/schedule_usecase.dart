import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/domain/models/pagination.dart';

import '../repositories/schedule_repo.dart';

@injectable
class ScheduleUseCase {
  final ScheduleRepository scheduleRepository;

  ScheduleUseCase(this.scheduleRepository);

  Future<Either<String, Pagination<BookingInfoEntity>>> getListBooking({
    required int page,
    String orderBy = 'meeting',
    String sortBy = 'desc',
    required int perPage,
    required DateTime dateTime,
    required bool isHistoryGet,
  }) =>
      scheduleRepository
          .getBookingList(
            page: page,
            perPage: perPage,
            time: dateTime,
            isHistoryGet: isHistoryGet,
          )
          .mapRight(
            (right) => Pagination<BookingInfoEntity>(
              rows: right.booking,
              count: right.count,
              currentPage: page,
              perPage: perPage,
            ),
          );

  Future<Either<String, List<BookingInfoEntity>>> getNextAppointment(
          DateTime time) =>
      scheduleRepository
          .getNextAppointment(dateTime: time)
          .mapRight((right) => right.data);

  Future<Either<String, bool>> cancelBookedSchedule(
          {required List<String> schedulesId}) =>
      scheduleRepository.cancelBookedSchedule(schedulesId: schedulesId);
}
