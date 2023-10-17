import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/data/entities/tutor/tutor_detail_entity.dart';
import 'package:lettutor/data/entities/tutor/tutor_entity.dart';
import 'package:lettutor/data/entities/tutor/tutor_user_detail_entity.dart';
import 'package:lettutor/domain/models/course/course_preview.dart';
import 'package:lettutor/domain/models/tutor/tutor.dart';
import 'package:lettutor/domain/models/tutor/tutor_detail.dart';
import 'package:lettutor/domain/models/tutor/tutor_user_detail.dart';

class TutorMapper {
  static Tutor fromTutorEntity(TutorEntity entity, {bool? isFavorite}) {
    return Tutor(
      id: entity.id,
      level: entity.level ?? "",
      email: entity.email ?? "",
      google: entity.google ?? "",
      facebook: entity.facebook ?? "",
      apple: entity.apple ?? "",
      avatar: entity.avatar ?? "",
      name: entity.name ?? "",
      country: entity.country ?? "",
      phone: entity.phone ?? "",
      language: entity.language ?? "",
      birthday: entity.birthday ?? DateTime.now(),
      requestPassword: entity.requestPassword ?? false,
      isActivated: entity.isActivated ?? false,
      isPhoneActivated: entity.isPhoneActivated ?? false,
      requireNote: entity.requireNote ?? "",
      timezone: entity.timezone ?? 0,
      phoneAuth: entity.phoneAuth ?? "",
      isPhoneAuthActivated: entity.isPhoneAuthActivated ?? false,
      canSendMessage: entity.canSendMessage ?? false,
      isPublicRecord: entity.isPublicRecord ?? false,
      caredByStaffId: entity.caredByStaffId ?? "",
      createdAt: entity.createdAt ?? DateTime.now(),
      updatedAt: entity.updatedAt ?? DateTime.now(),
      deletedAt: entity.deletedAt ?? "",
      studentGroupId: entity.studentGroupId ?? "",
      userId: entity.userId ?? "",
      video: entity.video ?? "",
      bio: entity.bio ?? "",
      education: entity.education ?? "",
      experience: entity.experience ?? "",
      profession: entity.profession ?? "",
      accent: entity.accent ?? "",
      targetStudent: entity.targetStudent ?? "",
      interests: entity.interests ?? "",
      languages: entity.languages ?? "",
      specialties: entity.specialties ?? "",
      resume: entity.resume ?? "",
      rating: entity.rating ?? 0,
      isNative: entity.isNative ?? false,
      price: entity.price ?? 0,
      isOnline: entity.isOnline ?? false,
      isFavoriteTutor: entity.isFavoriteTutor ?? isFavorite ?? false,
    );
  }

  static TutorDetail fromTutorDetailEntity(TutorDetailEntity entity) {
    return TutorDetail(
      video: entity.video,
      bio: entity.bio,
      education: entity.education,
      experience: entity.experience,
      profession: entity.profession,
      accent: entity.accent,
      targetStudent: entity.targetStudent,
      interests: entity.interests,
      languages: entity.languages,
      specialties: entity.specialties,
      rating: entity.rating,
      avgRating: entity.avgRating,
      totalFeedback: entity.totalFeedback,
      isNative: entity.isNative,
      isFavorite: entity.isFavorite,
      youtubeVideoId: entity.youtubeVideoId,
      user: entity.user != null ? fromTutorUserEntity(entity.user!) : null,
    );
  }

  static TutorUserDetail fromTutorUserEntity(TutorUserDetailEntity entity) =>
      TutorUserDetail(
        id: entity.id,
        level: entity.level,
        avatar: entity.avatar,
        name: entity.name,
        country: entity.country,
        language: entity.language,
        isPublicRecord: entity.isPublicRecord,
        caredByStaffId: entity.caredByStaffId,
        studentGroupId: entity.studentGroupId,
        zaloUserId: entity.zaloUserId,
        courses: entity.courses
            .map((e) => CoursePreview(id: e.id, name: e.name))
            .toList(),
      );
}
