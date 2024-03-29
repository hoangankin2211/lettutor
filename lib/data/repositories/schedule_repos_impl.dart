import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/schedule/schedule_service.dart';
import 'package:lettutor/data/entities/response/booking_info_response.dart';
import 'package:lettutor/data/entities/response/schedule_response.dart';
import 'package:lettutor/data/entities/response/upcoming_class_response.dart';

import '../../core/utils/networking/data_state.dart';
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
    // if (isHistoryGet) {
    //   queries.addAll(
    //     {'dateTimeLte': time.millisecondsSinceEpoch},
    //   );
    // } else {
    //   queries.addAll(
    //     {'dateTimeGte': time.millisecondsSinceEpoch},
    //   );
    // }
    final response = await getStateOf<BookingResponse>(
      request: () async =>
          scheduleService.getScheduleListForStudent(queries: queries),
      parser: (data) => compute(BookingResponse.fromJson, data),
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
      request: () => scheduleService.getNextAppointment(),
      parser: (data) => compute(UpcomingClassResponse.fromJson, data),
    );

    if (response is DataSuccess) {
      if (response.data != null) {
        return Right(response.data!);
      }
    }

    return Left("Error: ${response.dioException?.message}");
  }

  @override
  Future<Either<String, bool>> cancelBookedSchedule(
      {required List<String> schedulesId}) async {
    final result = await getStateOf(
      request: () => scheduleService
          .cancelScheduleClass(body: {"scheduleDetailIds": schedulesId}),
    );

    return result.isSuccess().mapLeft(
          (left) =>
              (result.statusCode == 400
                  ? left.response?.data["message"]
                  : left.message) ??
              "Error: Can not cancel the booked schedule",
        );
  }

  @override
  Future<Either<String, ScheduleResponse>> getScheduleByTutorId({
    required String tutorId,
    required int from,
    required int to,
  }) async {
    final dataState = await getStateOf(
      request: () async =>
          scheduleService.getScheduleByTutor(tutorId, from, to),
      parser: (data) => compute(ScheduleResponse.fromJson, data),
    );

    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        return Right(dataState.data!);
      }
    }

    return Left("Error: ${dataState.dioException?.message}");
  }

  @override
  Future<Either<String, bool>> bookClass(
      {required List<String> scheduleId, required String studentNote}) async {
    final result = await getStateOf(
      request: () async => await scheduleService.bookClass(body: {
        'scheduleDetailIds': scheduleId,
        'note': studentNote,
      }),
    );

    if (result is DataSuccess) {
      return const Right(true);
    }

    return Left(result.dioException?.response?.data["message"] ??
        (result.dioException!.message) ??
        "Error: Can not book this tutor");
  }

  @override
  Future<DataState> changeStudentRequest(
      String bookedId, String newRequest) async {
    return await getStateOf(
      request: () => scheduleService.updateStudentRequest(
          id: bookedId, body: {"studentRequest": newRequest}),
    );
  }
}
