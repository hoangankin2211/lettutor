import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/entities/request/tutor_search_request.dart';
import 'package:lettutor/domain/mapper/tutor_mapper.dart';
import 'package:lettutor/domain/models/pagination.dart';
import 'package:lettutor/domain/models/tutor/tutor.dart';
import 'package:lettutor/domain/models/tutor/tutor_detail.dart';
import 'package:lettutor/domain/repositories/tutor_repo.dart';

@injectable
class TutorUseCase {
  final TutorRepository tutorRepository;

  TutorUseCase(this.tutorRepository);

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
}
