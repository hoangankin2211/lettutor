import 'package:lettutor/domain/models/course/course.dart';

class TutorUserDetail {
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
  final List<CoursePreview>? courses;

  TutorUserDetail({
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
    this.courses,
  });

  TutorUserDetail copyWith({
    String? id,
    String? level,
    String? avatar,
    String? name,
    String? country,
    String? language,
    bool? isPublicRecord,
    String? caredByStaffId,
    String? studentGroupId,
    String? zaloUserId,
    List<CoursePreview>? courses,
  }) {
    return TutorUserDetail(
      id: id ?? this.id,
      level: level ?? this.level,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      country: country ?? this.country,
      language: language ?? this.language,
      isPublicRecord: isPublicRecord ?? this.isPublicRecord,
      caredByStaffId: caredByStaffId ?? this.caredByStaffId,
      studentGroupId: studentGroupId ?? this.studentGroupId,
      zaloUserId: zaloUserId ?? this.zaloUserId,
      courses: courses ?? this.courses,
    );
  }
}
