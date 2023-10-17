import 'package:lettutor/data/entities/course/course_preview_entity.dart';

class TutorUserDetailEntity {
  final String id;
  final String? level;
  final String? avatar;
  final String? name;
  final String? country;
  final String? language;
  final bool? isPublicRecord;
  final String? caredByStaffId;
  final String? studentGroupId;
  final String? zaloUserId;
  final List<CoursePreviewEntity> courses;

  TutorUserDetailEntity({
    required this.id,
    this.level,
    this.avatar,
    this.name,
    this.country,
    this.language,
    this.isPublicRecord,
    this.caredByStaffId,
    this.studentGroupId,
    this.zaloUserId,
    required this.courses,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'level': level,
      'avatar': avatar,
      'name': name,
      'country': country,
      'language': language,
      'isPublicRecord': isPublicRecord,
      'caredByStaffId': caredByStaffId,
      'studentGroupId': studentGroupId,
      'zaloUserId': zaloUserId,
      'courses': courses.map((x) => x.toMap()).toList(),
    };
  }

  factory TutorUserDetailEntity.fromJson(Map<String, dynamic> map) {
    return TutorUserDetailEntity(
      id: map['id'] as String,
      level: map['level'] != null ? map['level'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      isPublicRecord:
          map['isPublicRecord'] != null ? map['isPublicRecord'] as bool : null,
      caredByStaffId: map['caredByStaffId'] != null
          ? map['caredByStaffId'] as String
          : null,
      studentGroupId: map['studentGroupId'] != null
          ? map['studentGroupId'] as String
          : null,
      zaloUserId:
          map['zaloUserId'] != null ? map['zaloUserId'] as String : null,
      courses: List<CoursePreviewEntity>.from(
        (map['courses'] as List<dynamic>).map<CoursePreviewEntity>(
          (x) => CoursePreviewEntity.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
