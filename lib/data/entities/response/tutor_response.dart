import 'package:lettutor/data/entities/tutor/tutor_entity.dart';

class TutorResponse {
  final int count;
  final List<TutorEntity> tutors;
  final List<String> favTutors;
  TutorResponse(this.count, this.tutors, this.favTutors);

  factory TutorResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['tutors'];
    if (cData == null) return TutorResponse(0, List.empty(), List.empty());
    return TutorResponse(
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => TutorEntity.fromJson(e))
              .toList()
          : List.empty(),
      data['favoriteTutor'] != null
          ? (data['favoriteTutor'] as List<dynamic>)
              .map((e) => e['secondId']?.toString().trim() ?? '')
              .toList()
          : List.empty(),
    );
  }
}
