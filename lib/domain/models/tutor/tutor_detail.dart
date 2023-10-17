// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'tutor_user_detail.dart';

class TutorDetail {
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
  final TutorUserDetail? user;

  const TutorDetail({
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

  TutorDetail copyWith({
    String? video,
    String? bio,
    String? education,
    String? experience,
    String? profession,
    String? accent,
    String? targetStudent,
    String? interests,
    String? languages,
    String? specialties,
    double? rating,
    double? avgRating,
    int? totalFeedback,
    bool? isNative,
    bool? isFavorite,
    String? youtubeVideoId,
    TutorUserDetail? user,
  }) {
    return TutorDetail(
      video: video ?? this.video,
      bio: bio ?? this.bio,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      profession: profession ?? this.profession,
      accent: accent ?? this.accent,
      targetStudent: targetStudent ?? this.targetStudent,
      interests: interests ?? this.interests,
      languages: languages ?? this.languages,
      specialties: specialties ?? this.specialties,
      rating: rating ?? this.rating,
      avgRating: avgRating ?? this.avgRating,
      totalFeedback: totalFeedback ?? this.totalFeedback,
      isNative: isNative ?? this.isNative,
      isFavorite: isFavorite ?? this.isFavorite,
      youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
      user: user ?? this.user,
    );
  }
}
