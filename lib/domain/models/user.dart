// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lettutor/data/entities/course/course_entity.dart';
import 'package:lettutor/data/entities/user_entity.dart';

class User {
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
  final WalletInfo? walletInfo;
  final List<CourseEntity>? courses;
  final String? requireNote;
  final String? level;
  final List<LearnTopics>? learnTopics;
  final List<TestPreparation>? testPreparations;
  final bool? isPhoneActivated;
  final int? timezone;
  final String? studySchedule;
  final bool? canSendMessage;

  User({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    this.walletInfo,
    this.courses,
    this.requireNote,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.studySchedule,
    this.canSendMessage,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? avatar,
    String? country,
    String? phone,
    List<String>? roles,
    String? language,
    String? birthday,
    bool? isActivated,
    WalletInfo? walletInfo,
    List<CourseEntity>? courses,
    String? requireNote,
    String? level,
    List<LearnTopics>? learnTopics,
    List<TestPreparation>? testPreparations,
    bool? isPhoneActivated,
    int? timezone,
    String? studySchedule,
    bool? canSendMessage,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      roles: roles ?? this.roles,
      language: language ?? this.language,
      birthday: birthday ?? this.birthday,
      isActivated: isActivated ?? this.isActivated,
      walletInfo: walletInfo ?? this.walletInfo,
      courses: courses ?? this.courses,
      requireNote: requireNote ?? this.requireNote,
      level: level ?? this.level,
      learnTopics: learnTopics ?? this.learnTopics,
      testPreparations: testPreparations ?? this.testPreparations,
      isPhoneActivated: isPhoneActivated ?? this.isPhoneActivated,
      timezone: timezone ?? this.timezone,
      studySchedule: studySchedule ?? this.studySchedule,
      canSendMessage: canSendMessage ?? this.canSendMessage,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, avatar: $avatar, country: $country, phone: $phone, roles: $roles, language: $language, birthday: $birthday, isActivated: $isActivated, walletInfo: $walletInfo, courses: $courses, requireNote: $requireNote, level: $level, learnTopics: $learnTopics, testPreparations: $testPreparations, isPhoneActivated: $isPhoneActivated, timezone: $timezone, studySchedule: $studySchedule, canSendMessage: $canSendMessage)';
  }
}

class TestPreparation {
  final int id;
  final String key;
  final String name;
  TestPreparation({
    required this.id,
    required this.key,
    required this.name,
  });

  TestPreparation copyWith({
    int? id,
    String? key,
    String? name,
  }) {
    return TestPreparation(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
    );
  }
}

class WalletInfo {
  final String id;
  final String userId;
  final String amount;
  final bool isBlocked;
  final String createdAt;
  final String updatedAt;
  final int bonus;
  WalletInfo({
    this.id = "",
    this.userId = "",
    required this.amount,
    required this.isBlocked,
    this.createdAt = "",
    this.updatedAt = "",
    required this.bonus,
  });

  WalletInfo copyWith({
    String? id,
    String? userId,
    String? amount,
    bool? isBlocked,
    String? createdAt,
    String? updatedAt,
    int? bonus,
  }) {
    return WalletInfo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      isBlocked: isBlocked ?? this.isBlocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bonus: bonus ?? this.bonus,
    );
  }
}
