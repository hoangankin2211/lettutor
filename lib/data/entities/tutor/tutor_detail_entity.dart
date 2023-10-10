import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TutorDetailEntity {
  final String? video;
  final String? bio;
  final String? education;
  final String? experience;
  final String? profession;
  final String? accent;
  final String? targetStudent;
  final String? interests;
  final String? languages;
  final String? specialties;
  final double? rating;
  final double? avgRating;
  final int? totalFeedback;
  final bool? isNative;
  final bool? isFavorite;
  final String? youtubeVideoId;
  final TutorUserDetailEntity? user;
  TutorDetailEntity({
    this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.accent,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties,
    this.rating,
    this.avgRating,
    this.totalFeedback,
    this.isNative,
    this.isFavorite,
    this.youtubeVideoId,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'video': video,
      'bio': bio,
      'education': education,
      'experience': experience,
      'profession': profession,
      'accent': accent,
      'targetStudent': targetStudent,
      'interests': interests,
      'languages': languages,
      'specialties': specialties,
      'rating': rating,
      'avgRating': avgRating,
      'totalFeedback': totalFeedback,
      'isNative': isNative,
      'isFavorite': isFavorite,
      'youtubeVideoId': youtubeVideoId,
      'user': user?.toMap(),
    };
  }

  factory TutorDetailEntity.fromJson(Map<String, dynamic> map) {
    return TutorDetailEntity(
      video: map['video'] != null ? map['video'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      education: map['education'] != null ? map['education'] as String : null,
      experience:
          map['experience'] != null ? map['experience'] as String : null,
      profession:
          map['profession'] != null ? map['profession'] as String : null,
      accent: map['accent'] != null ? map['accent'] as String : null,
      targetStudent:
          map['targetStudent'] != null ? map['targetStudent'] as String : null,
      interests: map['interests'] != null ? map['interests'] as String : null,
      languages: map['languages'] != null ? map['languages'] as String : null,
      specialties:
          map['specialties'] != null ? map['specialties'] as String : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      avgRating: map['avgRating'] != null ? map['avgRating'] as double : null,
      totalFeedback:
          map['totalFeedback'] != null ? map['totalFeedback'] as int : null,
      isNative: map['isNative'] != null ? map['isNative'] as bool : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
      youtubeVideoId: map['youtubeVideoId'] != null
          ? map['youtubeVideoId'] as String
          : null,
      user: map['user'] != null
          ? TutorUserDetailEntity.fromJson(map['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

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
        (map['courses'] as List<int>).map<CoursePreviewEntity>(
          (x) => CoursePreviewEntity.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class CoursePreviewEntity {
  final String courseId;
  final String name;
  CoursePreviewEntity({
    required this.courseId,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'courseId': courseId,
      'name': name,
    };
  }

  factory CoursePreviewEntity.fromJson(Map<String, dynamic> map) {
    return CoursePreviewEntity(
      courseId: map['courseId'] as String,
      name: map['name'] as String,
    );
  }
}
