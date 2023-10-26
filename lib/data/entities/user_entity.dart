// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'test_preparation.dart';
import 'wallet_info_entity.dart';

class UserEntity {
  final String id;
  final String email;
  final String name;
  final String avatar;
  final String country;
  final String phone;
  final List<String> roles;
  final String? language;
  final String birthday;
  final bool isActivated;
  final WalletInfoEntity walletInfo;
  final List<String> courses;
  final String requireNote;
  final String level;
  final List<LearnTopics> learnTopics;
  final List<TestPreparationEntity> testPreparations;
  final bool isPhoneActivated;
  final int timezone;
  final String studySchedule;
  final bool canSendMessage;

  UserEntity({
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
    required this.walletInfo,
    required this.courses,
    required this.requireNote,
    required this.level,
    required this.learnTopics,
    required this.testPreparations,
    required this.isPhoneActivated,
    required this.timezone,
    required this.studySchedule,
    required this.canSendMessage,
  });

  UserEntity copyWith({
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
    WalletInfoEntity? walletInfo,
    List<String>? courses,
    String? requireNote,
    String? level,
    List<LearnTopics>? learnTopics,
    List<TestPreparationEntity>? testPreparations,
    bool? isPhoneActivated,
    int? timezone,
    String? studySchedule,
    bool? canSendMessage,
  }) {
    return UserEntity(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'country': country,
      'phone': phone,
      'roles': roles,
      'language': language,
      'birthday': birthday,
      'isActivated': isActivated,
      'walletInfo': walletInfo.toMap(),
      'courses': courses,
      'requireNote': requireNote,
      'level': level,
      'learnTopics': learnTopics.map((e) => e.toMap()).toList(),
      'testPreparations': testPreparations.map((x) => x.toMap()).toList(),
      'isPhoneActivated': isPhoneActivated,
      'timezone': timezone,
      'studySchedule': studySchedule,
      'canSendMessage': canSendMessage,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      country: map['country'] as String,
      phone: map['phone'] as String,
      roles: List<String>.from(
          (map['roles'] as List<dynamic>).map((e) => e as String)),
      language: map['language'] as String?,
      birthday: map['birthday'] as String,
      isActivated: map['isActivated'] as bool,
      walletInfo:
          WalletInfoEntity.fromMap(map['walletInfo'] as Map<String, dynamic>),
      courses: List<String>.from(
          (map['courses'] as List<dynamic>).map((e) => e as String)),
      requireNote: map['requireNote'] as String,
      level: map['level'] as String,
      learnTopics: List<LearnTopics>.from(
        (map['learnTopics'] as List<dynamic>).map(
          (e) => LearnTopics.fromMap(
            e as Map<String, dynamic>,
          ),
        ),
      ),
      testPreparations: List<TestPreparationEntity>.from(
        (map['testPreparations'] as List<dynamic>).map<TestPreparationEntity>(
          (x) => TestPreparationEntity.fromJson(x as Map<String, dynamic>),
        ),
      ),
      isPhoneActivated: map['isPhoneActivated'] as bool,
      timezone: map['timezone'] as int,
      studySchedule: map['studySchedule'] as String,
      canSendMessage: map['canSendMessage'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, name: $name, avatar: $avatar, country: $country, phone: $phone, roles: $roles, language: $language, birthday: $birthday, isActivated: $isActivated, walletInfo: $walletInfo, courses: $courses, requireNote: $requireNote, level: $level, learnTopics: $learnTopics, testPreparations: $testPreparations, isPhoneActivated: $isPhoneActivated, timezone: $timezone, studySchedule: $studySchedule, canSendMessage: $canSendMessage)';
  }

  @override
  bool operator ==(covariant UserEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.name == name &&
        other.avatar == avatar &&
        other.country == country &&
        other.phone == phone &&
        listEquals(other.roles, roles) &&
        other.language == language &&
        other.birthday == birthday &&
        other.isActivated == isActivated &&
        other.walletInfo == walletInfo &&
        listEquals(other.courses, courses) &&
        other.requireNote == requireNote &&
        other.level == level &&
        listEquals(other.learnTopics, learnTopics) &&
        listEquals(other.testPreparations, testPreparations) &&
        other.isPhoneActivated == isPhoneActivated &&
        other.timezone == timezone &&
        other.studySchedule == studySchedule &&
        other.canSendMessage == canSendMessage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        avatar.hashCode ^
        country.hashCode ^
        phone.hashCode ^
        roles.hashCode ^
        language.hashCode ^
        birthday.hashCode ^
        isActivated.hashCode ^
        walletInfo.hashCode ^
        courses.hashCode ^
        requireNote.hashCode ^
        level.hashCode ^
        learnTopics.hashCode ^
        testPreparations.hashCode ^
        isPhoneActivated.hashCode ^
        timezone.hashCode ^
        studySchedule.hashCode ^
        canSendMessage.hashCode;
  }
}

class LearnTopics {
  final int id;
  final String key;
  final String name;
  LearnTopics({
    required this.id,
    required this.key,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'key': key,
      'name': name,
    };
  }

  factory LearnTopics.fromMap(Map<String, dynamic> map) {
    return LearnTopics(
      id: map['id'] as int,
      key: map['key'] as String,
      name: map['name'] as String,
    );
  }
}
