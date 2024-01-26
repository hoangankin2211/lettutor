import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/utils/networking/data_state.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/data/entities/schedule/schedule_entity.dart';
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

  Future<Either<String, BookingInfoEntity?>> getNextAppointment(
          DateTime time) =>
      scheduleRepository.getNextAppointment(dateTime: time).mapRight((right) {
        // final listData = right.data.where((element) {
        //   final startPeriodTimestamp =
        //       element.scheduleDetailInfo?.startPeriodTimestamp;
        //   if (startPeriodTimestamp != null) {
        //     return startPeriodTimestamp < time.millisecondsSinceEpoch;
        //   }
        //   return false;
        // }).toList();

        // if (listData.isEmpty) {
        //   return null;
        // }

        // listData.sort((a, b) {
        //   return a.scheduleDetailInfo!.startPeriodTimestamp
        //       .compareTo(b.scheduleDetailInfo!.startPeriodTimestamp);
        // });

        logger.d(right.data.first.scheduleDetailInfo!.startPeriodTimestamp);
        return right.data.first;
      });

  Future<Either<String, bool>> cancelBookedSchedule(
          {required List<String> schedulesId}) =>
      scheduleRepository.cancelBookedSchedule(schedulesId: schedulesId);

  Future<Either<String, List<ScheduleEntity>>> getScheduleByTutorId({
    required String tutorId,
    required DateTime from,
    required DateTime to,
  }) =>
      scheduleRepository
          .getScheduleByTutorId(
            tutorId: tutorId,
            from: from.millisecondsSinceEpoch,
            to: to.millisecondsSinceEpoch,
          )
          .mapRight((right) => right.schedules
            ..sort(
              (a, b) => a.startTimestamp.compareTo(b.startTimestamp),
            ));

  Future<Either<String, bool>> bookClassById({
    required List<String> scheduleIds,
    String studentNote = "",
  }) =>
      scheduleRepository.bookClass(
          scheduleId: scheduleIds, studentNote: studentNote);

  Future<DataState> editRequest(String bookId, String request) {
    return scheduleRepository.changeStudentRequest(bookId, request);
  }
}
