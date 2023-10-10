// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:lettutor/data/entities/tutor/tutor_entity.dart';

class ScheduleInfoEntity {
  final String id;

  final String tutorId;

  final String date;

  final String startTime;

  final String endTime;

  final int startTimestamp;

  final int endTimestamp;

  final bool isDeleted;

  final DateTime createdAt;

  final DateTime updatedAt;

  final TutorEntity tutorInfo;
  ScheduleInfoEntity({
    required this.id,
    required this.tutorId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.tutorInfo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tutorId': tutorId,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'startTimestamp': startTimestamp,
      'endTimestamp': endTimestamp,
      'isDeleted': isDeleted,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'tutorInfo': tutorInfo.toMap(),
    };
  }

  factory ScheduleInfoEntity.fromJson(Map<String, dynamic> map) {
    return ScheduleInfoEntity(
      id: map['id'] as String,
      tutorId: map['tutorId'] as String,
      date: map['date'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      startTimestamp: map['startTimestamp'] as int,
      endTimestamp: map['endTimestamp'] as int,
      isDeleted: map['isDeleted'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      tutorInfo: TutorEntity.fromMap(map['tutorInfo'] as Map<String, dynamic>),
    );
  }
}
