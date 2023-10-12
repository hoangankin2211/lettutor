import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/components/networking/data_state.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/tutorial/tutor_service.dart';

import 'package:lettutor/data/entities/request/tutor_search_request.dart';

import 'package:lettutor/data/entities/response/tutor_response.dart';

import 'package:lettutor/data/entities/schedule/schedule_entity.dart';

import 'package:lettutor/data/entities/tutor/tutor_detail_entity.dart';

import 'package:lettutor/data/entities/tutor/tutor_entity.dart';

import '../../domain/repositories/tutor_repo.dart';
import '../entities/response/search_tutor_response.dart';

@Injectable(as: TutorRepository)
class TutorRepositoryImpl extends TutorRepository {
  final TutorService tutorService;

  TutorRepositoryImpl(this.tutorService);

  @override
  Future<Either<String, TutorResponse>> fetchListTutor(
      {required int perPage, required int page}) async {
    final dataState = await getStateOf<TutorResponse>(
      request: () async => await tutorService.fetchTutorialPage(
        page: page,
        size: page,
      ),
    );

    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        return Right(dataState.data!);
      }
      return const Left("Data is Null");
    }
    return Left(dataState.dioException?.message ?? "Error while fetching");
  }

  @override
  Future<Either<String, TutorDetailEntity>> getTutorDetail(
      {required String id}) async {
    final dataState = await getStateOf<TutorDetailEntity>(
      request: () async => await tutorService.getTutorById(id),
    );

    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        return Right(dataState.data!);
      }
      return const Left("Data is Null");
    }
    return Left(dataState.dioException?.message ??
        "Can not get the tutor detail. Please try again!");
  }

  @override
  Future<Either<String, ScheduleEntity>> getTutorSchedule(
      {required String id,
      required DateTime startTime,
      required DateTime endTime}) async {
    //      final dataState = await getStateOf<ScheduleEntity>(
    //   request: () async => await tutorService.(id),
    // );

    // if (dataState is DataSuccess) {
    //   if (dataState.data != null) {
    //     return Right(dataState.data!);
    //   }
    //   return const Left("Data is Null");
    // }
    // return Left(dataState.dioException?.message ??
    //     "Can not get the tutor detail. Please try again!",);
    throw UnimplementedError();
  }

  @override
  Future<bool> markFavoriteTutor({required String tutorId}) async {
    final dataState = await getStateOf(
      request: () async =>
          tutorService.addTutorToFavorite(body: {"tutorId": tutorId}),
    );
    if (dataState is DataSuccess && dataState.statusCode == 201) {
      return true;
    }

    return false;
  }

  @override
  Future<Either<String, SearchTutorResponse>> searchTutor(
      {required TutorSearchRequest request}) async {
    final dataState = await getStateOf<SearchTutorResponse>(
        request: () async =>
            await tutorService.searchTutor(body: request.toMap()));

    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        return Right(dataState.data!);
      }
      return const Left("Data is Null");
    }
    return Left(
        dataState.dioException?.message ?? "Error: Can not search tutor");
  }
}
