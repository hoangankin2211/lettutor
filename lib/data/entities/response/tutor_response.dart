import 'package:lettutor/data/entities/tutor/tutor_entity.dart';

class TutorResponse {
  final int count;
  final List<TutorEntity> tutors;
  final List<String> favTutors;
  TutorResponse(
      {required this.count, required this.tutors, required this.favTutors});

  static TutorResponse fromJson(Map<String, dynamic> data) {
    final cData = data['tutors'];
    if (cData == null) {
      return TutorResponse(
        count: 0,
        tutors: List.empty(),
        favTutors: List.empty(),
      );
    }
    return TutorResponse(
      count: (cData['count'] as int?) ?? 0,
      tutors: cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => TutorEntity.fromJson(e))
              .toList()
          : List.empty(),
      favTutors: data['favoriteTutor'] != null
          ? (data['favoriteTutor'] as List<dynamic>)
              .map((e) => e['secondId']?.toString().trim() ?? '')
              .toList()
          : List.empty(),
    );
  }
}
