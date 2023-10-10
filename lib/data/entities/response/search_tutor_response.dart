import 'package:lettutor/data/entities/tutor/tutor_entity.dart';

class SearchTutorResponse {
  final int count;
  final List<TutorEntity> tutors;

  SearchTutorResponse(this.count, this.tutors);

  factory SearchTutorResponse.fromJson(Map<String, dynamic> data) {
    return SearchTutorResponse(
      (data['count'] as int?) ?? 0,
      data['rows'] != null
          ? ((data['rows']) as List<dynamic>)
              .map((e) => TutorEntity.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}
