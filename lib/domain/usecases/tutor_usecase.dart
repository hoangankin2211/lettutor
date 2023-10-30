import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/networking/data_state.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/review/feedback_service.dart';
import 'package:lettutor/data/data_source/remote/tutorial/tutor_service.dart';
import 'package:lettutor/data/entities/feedback/feedback_entity.dart';
import 'package:lettutor/data/entities/request/tutor_search_request.dart';
import 'package:lettutor/domain/mapper/tutor_mapper.dart';
import 'package:lettutor/domain/models/pagination.dart';
import 'package:lettutor/domain/models/tutor/tutor.dart';
import 'package:lettutor/domain/models/tutor/tutor_detail.dart';
import 'package:lettutor/domain/repositories/tutor_repo.dart';

@injectable
class TutorUseCase {
  final TutorRepository tutorRepository;
  final TutorService tutorService;
  final FeedbackService feedbackService;

  TutorUseCase(this.tutorRepository, this.feedbackService, this.tutorService);

  Future<Either<String, Pagination<Tutor>>> fetchTutorPage({
    required int page,
    required int perPage,
  }) =>
      tutorRepository.fetchListTutor(perPage: perPage, page: page).mapRight(
            (tutorResponse) => Pagination(
              rows: tutorResponse.tutors
                  .map((tutorEntity) => TutorMapper.fromTutorEntity(
                        tutorEntity,
                        isFavorite:
                            tutorResponse.favTutors.contains(tutorEntity.id),
                      ))
                  .toList(),
              count: tutorResponse.count,
              currentPage: page,
              perPage: perPage,
            ),
          );

  Future<Either<String, List<FeedbackEntity>>> getFeedbackById(
          {required String userId, int page = 2, int perPage = 10}) =>
      tutorRepository
          .getTutorFeedbackById(
            id: userId,
            page: page,
            perPage: perPage,
          )
          .mapRight((right) => right.reviews);

  Future<Either<String, TutorDetail>> getTutorById({required String tutorId}) =>
      tutorRepository
          .getTutorDetail(id: tutorId)
          .mapRight(TutorMapper.fromTutorDetailEntity);

  Future<bool> markFavoriteTutor({required String id}) =>
      tutorRepository.markFavoriteTutor(tutorId: id);

  Future<Either<String, Pagination<Tutor>>> searchTutorByFilter(
          TutorSearchRequest filter) =>
      tutorRepository.searchTutor(request: filter).mapRight(
            (response) => Pagination(
              rows: response.tutors.map(TutorMapper.fromTutorEntity).toList(),
              count: response.count,
              currentPage: filter.page,
              perPage: filter.perPage,
            ),
          );

  Future<int> getTotalTime() async {
    final dataState = await getStateOf(
      request: () async {
        final response = await tutorService.getTotalTime();
        return response;
      },
    );

    if (dataState is DataFailed) {
      return 0;
    }

    return (dataState.data as Map<String, dynamic>?)?['total'] ?? 0;
  }
}
