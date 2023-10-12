// ignore_for_file: public_member_api_docs, sort_constructors_first
class Tutor {
  final String id;
  final String? level;
  final String? email;
  final String? google;
  final String? facebook;
  final String? apple;
  final String? avatar;
  final String? name;
  final String? country;
  final String? phone;
  final String? language;
  final DateTime? birthday;
  final bool? requestPassword;
  final bool? isActivated;
  final bool? isPhoneActivated;
  final String? requireNote;
  final int? timezone;
  final String? phoneAuth;
  final bool? isPhoneAuthActivated;
  // final String? studySchedule;
  final bool? canSendMessage;
  final bool? isPublicRecord;
  final String? caredByStaffId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final String? studentGroupId;
  final String? userId;
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
  final String? resume;
  final double? rating;
  final bool? isNative;
  final double? price;
  final bool? isOnline;
  final bool? isFavoriteTutor;

  Tutor({
    required this.id,
    this.level,
    this.email,
    this.google,
    this.facebook,
    this.apple,
    this.avatar,
    this.name,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.requestPassword,
    this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated,
    this.canSendMessage,
    this.isPublicRecord,
    this.caredByStaffId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.studentGroupId,
    this.userId,
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
    this.resume,
    this.rating,
    this.isNative,
    this.price,
    this.isOnline,
    this.isFavoriteTutor = false,
  });

  Tutor copyWith({
    String? id,
    String? level,
    String? email,
    String? google,
    String? facebook,
    String? apple,
    String? avatar,
    String? name,
    String? country,
    String? phone,
    String? language,
    DateTime? birthday,
    bool? requestPassword,
    bool? isActivated,
    bool? isPhoneActivated,
    String? requireNote,
    int? timezone,
    String? phoneAuth,
    bool? isPhoneAuthActivated,
    bool? canSendMessage,
    bool? isPublicRecord,
    String? caredByStaffId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deletedAt,
    String? studentGroupId,
    String? userId,
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
    String? resume,
    double? rating,
    bool? isNative,
    double? price,
    bool? isOnline,
    bool? isFavorite,
  }) {
    return Tutor(
      id: id ?? this.id,
      level: level ?? this.level,
      email: email ?? this.email,
      google: google ?? this.google,
      facebook: facebook ?? this.facebook,
      apple: apple ?? this.apple,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      language: language ?? this.language,
      birthday: birthday ?? this.birthday,
      requestPassword: requestPassword ?? this.requestPassword,
      isActivated: isActivated ?? this.isActivated,
      isPhoneActivated: isPhoneActivated ?? this.isPhoneActivated,
      requireNote: requireNote ?? this.requireNote,
      timezone: timezone ?? this.timezone,
      phoneAuth: phoneAuth ?? this.phoneAuth,
      isPhoneAuthActivated: isPhoneAuthActivated ?? this.isPhoneAuthActivated,
      canSendMessage: canSendMessage ?? this.canSendMessage,
      isPublicRecord: isPublicRecord ?? this.isPublicRecord,
      caredByStaffId: caredByStaffId ?? this.caredByStaffId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      studentGroupId: studentGroupId ?? this.studentGroupId,
      userId: userId ?? this.userId,
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
      resume: resume ?? this.resume,
      rating: rating ?? this.rating,
      isNative: isNative ?? this.isNative,
      price: price ?? this.price,
      isOnline: isOnline ?? this.isOnline,
      isFavoriteTutor: isFavorite ?? this.isActivated,
    );
  }
}
