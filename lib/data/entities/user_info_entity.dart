import 'package:lettutor/data/entities/test_preparation.dart';
import 'package:lettutor/data/entities/user_entity.dart';

class UserInfoResponse {
  final UserData user;
  UserInfoResponse({
    required this.user,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> map) {
    return UserInfoResponse(
      user: UserData.fromJson(map['user'] as Map<String, dynamic>),
    );
  }
}

class TutorInfo {
  final String id;
  final String video;
  final String bio;
  final String education;
  final String experience;
  final String profession;
  final String targetStudent;
  final String interests;
  final String? languages;
  final String specialties;
  final double rating;
  final bool isActivated;
  final bool isNative;
  final String? youtubeVideoId;

  TutorInfo({
    required this.id,
    required this.video,
    required this.bio,
    required this.education,
    required this.experience,
    required this.profession,
    required this.targetStudent,
    required this.interests,
    this.languages,
    required this.specialties,
    required this.rating,
    required this.isActivated,
    required this.isNative,
    this.youtubeVideoId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'video': video,
      'bio': bio,
      'education': education,
      'experience': experience,
      'profession': profession,
      'targetStudent': targetStudent,
      'interests': interests,
      'languages': languages,
      'specialties': specialties,
      'rating': rating,
      'isActivated': isActivated,
      'isNative': isNative,
      'youtubeVideoId': youtubeVideoId,
    };
  }

  factory TutorInfo.fromJson(Map<String, dynamic> map) {
    return TutorInfo(
      id: map['id'] as String,
      video: map['video'] as String,
      bio: map['bio'] as String,
      education: map['education'] as String,
      experience: map['experience'] as String,
      profession: map['profession'] as String,
      targetStudent: map['targetStudent'] as String,
      interests: map['interests'] as String,
      languages: map['languages'],
      specialties: map['specialties'] as String,
      rating: (map['rating'] as int).toDouble(),
      isActivated: map['isActivated'] as bool,
      isNative: map['isNative'] as bool,
      youtubeVideoId: map['youtubeVideoId'],
    );
  }
}

class WalletUserInfo {
  final String amount;
  final bool isBlocked;
  final int bonus;

  WalletUserInfo({
    required this.amount,
    required this.isBlocked,
    required this.bonus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'isBlocked': isBlocked,
      'bonus': bonus,
    };
  }

  factory WalletUserInfo.fromJson(Map<String, dynamic> map) {
    return WalletUserInfo(
      amount: map['amount'] as String,
      isBlocked: map['isBlocked'] as bool,
      bonus: map['bonus'] as int,
    );
  }
}

class ReferralPackInfo {
  final int earnPercent;

  ReferralPackInfo({
    required this.earnPercent,
  });

  factory ReferralPackInfo.fromJson(Map<String, dynamic> json) {
    return ReferralPackInfo(
      earnPercent: json['earnPercent'],
    );
  }
}

class ReferralInfo {
  final String referralCode;
  final ReferralPackInfo referralPackInfo;

  ReferralInfo({
    required this.referralCode,
    required this.referralPackInfo,
  });

  factory ReferralInfo.fromJson(Map<String, dynamic> json) {
    return ReferralInfo(
      referralCode: json['referralCode'],
      referralPackInfo: ReferralPackInfo.fromJson(json['referralPackInfo']),
    );
  }
}

class UserData {
  final String? id;
  final String? email;
  final String? name;
  final String? avatar;
  final String? country;
  final String? phone;
  final List<String>? roles;
  final String? language;
  final String? birthday;
  final bool? isActivated;
  final TutorInfo? tutorInfo;
  final WalletUserInfo? walletInfo;
  final String? requireNote;
  final String? level;
  final List<LearnTopics>? learnTopics;
  final List<TestPreparationEntity>? testPreparations;
  final bool? isPhoneActivated;
  final int? timezone;
  final ReferralInfo? referralInfo;
  final String? studySchedule;
  final bool? canSendMessage;
  final dynamic? studentGroup;
  final dynamic? studentInfo;
  final double? avgRating;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.country,
    required this.phone,
    required this.roles,
    required this.language,
    required this.birthday,
    required this.isActivated,
    required this.tutorInfo,
    required this.walletInfo,
    required this.requireNote,
    required this.level,
    required this.learnTopics,
    required this.testPreparations,
    required this.isPhoneActivated,
    required this.timezone,
    required this.referralInfo,
    required this.studySchedule,
    required this.canSendMessage,
    required this.studentGroup,
    required this.studentInfo,
    required this.avgRating,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    var rolesList = json['roles'] as List;
    List<String> roles = rolesList.map((e) => e.toString()).toList();

    var learnTopicsList = json['learnTopics'] as List;
    List<LearnTopics> learnTopics =
        learnTopicsList.map((e) => LearnTopics.fromMap(e)).toList();

    var testPreparationsList = json['testPreparations'] as List;
    List<TestPreparationEntity> testPreparations = testPreparationsList
        .map((e) => TestPreparationEntity.fromJson(e))
        .toList();

    return UserData(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      country: json['country'],
      phone: json['phone'],
      roles: roles,
      language: json['language'] ?? "en",
      birthday: json['birthday'],
      isActivated: json['isActivated'],
      tutorInfo: json['tutorInfo'] != null
          ? TutorInfo.fromJson(json['tutorInfo'])
          : null,
      walletInfo: json['walletInfo'] != null
          ? WalletUserInfo.fromJson(json['walletInfo'])
          : null,
      requireNote: json['requireNote'],
      level: json['level'],
      learnTopics: learnTopics,
      testPreparations: testPreparations,
      isPhoneActivated: json['isPhoneActivated'],
      timezone: json['timezone'],
      referralInfo: json['referralInfo'] != null
          ? ReferralInfo.fromJson(json['referralInfo'])
          : null,
      studySchedule: json['studySchedule'],
      canSendMessage: json['canSendMessage'],
      studentGroup: json['studentGroup'],
      studentInfo: json['studentInfo'],
      avgRating:
          // ignore: prefer_null_aware_operators
          json['avgRating'] != null ? json['avgRating']!.toDouble() : null,
    );
  }
}
