import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/schedule/schedule_service.dart';
import 'package:lettutor/data/entities/response/booking_info_response.dart';
import 'package:lettutor/data/entities/response/upcoming_class_response.dart';

import '../../core/components/networking/data_state.dart';
import '../../domain/repositories/schedule_repo.dart';

@Injectable(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleService scheduleService;

  ScheduleRepositoryImpl(this.scheduleService);

  @override
  Future<Either<String, BookingResponse>> getBookingList({
    required int page,
    required int perPage,
    String orderBy = 'meeting',
    String sortBy = 'desc',
    required DateTime time,
    required bool isHistoryGet,
  }) async {
    final queries = <String, dynamic>{
      'page': page,
      'perPage': perPage,
      'orderBy': orderBy,
      'sortBy': sortBy,
    };
    if (isHistoryGet) {
      queries.addAll(
        {'dateTimeLte': time.millisecondsSinceEpoch},
      );
    } else {
      queries.addAll(
        {'dateTimeGte': time.millisecondsSinceEpoch},
      );
    }
    final response = await getStateOf<BookingResponse>(
      request: () async =>
          scheduleService.getScheduleListForStudent(queries: queries),
    );
    if (response is DataFailed) {
      return Left("Error: ${response.dioException?.message}");
    }

    final responseData = response.data;

    if (responseData == null) {
      return const Left("Data null");
    }

    return Right(response.data!);
  }

  @override
  Future<Either<String, UpcomingClassResponse>> getNextAppointment(
      {required DateTime dateTime}) async {
    final response = await getStateOf(
        request: () => scheduleService.getNextAppointment(
            time: dateTime.millisecondsSinceEpoch));

    if (response is DataSuccess) {
      if (response.data != null) {
        return Right(response.data!);
      }
    }

    return Left("Error: ${response.dioException?.message}");
  }
}