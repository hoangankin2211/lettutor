// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'schedule_detail_entity.dart';

class ScheduleEntity {
  final String id;

  final String tutorId;

  final String startTime;

  final String endTime;

  final int startTimestamp;

  final int endTimestamp;

  final DateTime createdAt;

  final bool isBooked;

  final List<ScheduleDetailEntity> scheduleDetails;
  ScheduleEntity({
    required this.id,
    required this.tutorId,
    required this.startTime,
    required this.endTime,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.createdAt,
    required this.isBooked,
    required this.scheduleDetails,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tutorId': tutorId,
      'startTime': startTime,
      'endTime': endTime,
      'startTimestamp': startTimestamp,
      'endTimestamp': endTimestamp,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isBooked': isBooked,
      'scheduleDetails': scheduleDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory ScheduleEntity.fromJson(Map<String, dynamic> map) {
    return ScheduleEntity(
      id: map['id'] as String,
      tutorId: map['tutorId'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      startTimestamp: map['startTimestamp'] as int,
      endTimestamp: map['endTimestamp'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      isBooked: map['isBooked'] as bool,
      scheduleDetails: List<ScheduleDetailEntity>.from(
        (map['scheduleDetails'] as List<int>).map<ScheduleDetailEntity>(
          (x) => ScheduleDetailEntity.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
