class UpdateProfileRequest {
  final String name;
  final String birthday;
  final String country;
  final List<String> learnTopics;
  final String level;
  final String phone;
  final String studySchedule;
  final List<String> testPreparations;
  UpdateProfileRequest({
    required this.name,
    required this.birthday,
    required this.country,
    required this.learnTopics,
    required this.level,
    required this.phone,
    required this.studySchedule,
    required this.testPreparations,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'birthday': birthday,
      'country': country,
      'learnTopics': learnTopics,
      'level': level,
      'phone': phone,
      'studySchedule': studySchedule,
      'testPreparations': testPreparations,
    };
  }

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> map) {
    return UpdateProfileRequest(
      name: map['name'] as String,
      birthday: map['birthday'] as String,
      country: map['country'] as String,
      learnTopics: List<dynamic>.from(map['learnTopics'])
          .map((x) => x as String)
          .toList(),
      level: map['level'] as String,
      phone: map['phone'] as String,
      studySchedule: map['studySchedule'] as String,
      testPreparations: List<dynamic>.from(map['testPreparations'])
          .map((e) => e as String)
          .toList(),
    );
  }
}
