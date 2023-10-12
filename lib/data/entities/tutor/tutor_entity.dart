class TutorEntity {
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
  //final String? studySchedule;
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

  TutorEntity({
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
    this.isFavoriteTutor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'level': level,
      'email': email,
      'google': google,
      'facebook': facebook,
      'apple': apple,
      'avatar': avatar,
      'name': name,
      'country': country,
      'phone': phone,
      'language': language,
      'birthday': birthday?.millisecondsSinceEpoch,
      'requestPassword': requestPassword,
      'isActivated': isActivated,
      'isPhoneActivated': isPhoneActivated,
      'requireNote': requireNote,
      'timezone': timezone,
      'phoneAuth': phoneAuth,
      'isPhoneAuthActivated': isPhoneAuthActivated,
      'canSendMessage': canSendMessage,
      'isPublicRecord': isPublicRecord,
      'caredByStaffId': caredByStaffId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'deletedAt': deletedAt,
      'studentGroupId': studentGroupId,
      'userId': userId,
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
      'resume': resume,
      'rating': rating,
      'isNative': isNative,
      'price': price,
      'isOnline': isOnline,
    };
  }

  factory TutorEntity.fromJson(Map<String, dynamic> map) {
    return TutorEntity(
      id: map['id'] as String,
      level: map['level'] != null ? map['level'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      google: map['google'] != null ? map['google'] as String : null,
      facebook: map['facebook'] != null ? map['facebook'] as String : null,
      apple: map['apple'] != null ? map['apple'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      birthday:
          map['birthday'] != null ? DateTime.parse(map['birthday']) : null,
      requestPassword: map['requestPassword'] != null
          ? map['requestPassword'] as bool
          : null,
      isActivated:
          map['isActivated'] != null ? map['isActivated'] as bool : null,
      isPhoneActivated: map['isPhoneActivated'] != null
          ? map['isPhoneActivated'] as bool
          : null,
      requireNote:
          map['requireNote'] != null ? map['requireNote'] as String : null,
      timezone: map['timezone'] != null ? map['timezone'] as int : null,
      phoneAuth: map['phoneAuth'] != null ? map['phoneAuth'] as String : null,
      isPhoneAuthActivated: map['isPhoneAuthActivated'] != null
          ? map['isPhoneAuthActivated'] as bool
          : null,
      canSendMessage:
          map['canSendMessage'] != null ? map['canSendMessage'] as bool : null,
      isPublicRecord:
          map['isPublicRecord'] != null ? map['isPublicRecord'] as bool : null,
      caredByStaffId: map['caredByStaffId'] != null
          ? map['caredByStaffId'] as String
          : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
      studentGroupId: map['studentGroupId'] != null
          ? map['studentGroupId'] as String
          : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
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
      resume: map['resume'] != null ? map['resume'] as String : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      isNative: map['isNative'] != null ? map['isNative'] as bool : null,
      price: map['price'] != null ? (map['price'] as int).toDouble() : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      isFavoriteTutor: map['isFavoriteTutor'] != null
          ? map['isFavoriteTutor'] as bool
          : false,
    );
  }
}
