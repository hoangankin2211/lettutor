import 'tutor_user_detail_entity.dart';

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
      'User': user?.toMap(),
    };
  }

  static TutorDetailEntity fromJson(Map<String, dynamic> map) {
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
      avgRating: map['avgRating'] != null
          ? (map['avgRating'] as num).toDouble()
          : null,
      totalFeedback:
          map['totalFeedback'] != null ? map['totalFeedback'] as int : null,
      isNative: map['isNative'] != null ? map['isNative'] as bool : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
      youtubeVideoId: map['youtubeVideoId'] != null
          ? map['youtubeVideoId'] as String
          : null,
      user: map['User'] != null
          ? TutorUserDetailEntity.fromJson(map['User'] as Map<String, dynamic>)
          : null,
    );
  }
}
