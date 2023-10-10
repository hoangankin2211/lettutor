// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:lettutor/data/data_source/remote/tutorial/tutor_service.dart';

import 'schedule_info_entity.dart';

class ScheduleDetailEntity {
  final String id;

  final String scheduleId;

  final String startPeriod;

  final String endPeriod;

  final DateTime createdAt;

  final DateTime updatedAt;

  final int startPeriodTimestamp;

  final int endPeriodTimestamp;

  final ScheduleInfoEntity? scheduleInfo;
  ScheduleDetailEntity({
    required this.id,
    required this.scheduleId,
    required this.startPeriod,
    required this.endPeriod,
    required this.createdAt,
    required this.updatedAt,
    required this.startPeriodTimestamp,
    required this.endPeriodTimestamp,
    this.scheduleInfo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'scheduleId': scheduleId,
      'startPeriod': startPeriod,
      'endPeriod': endPeriod,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'startPeriodTimestamp': startPeriodTimestamp,
      'endPeriodTimestamp': endPeriodTimestamp,
      'scheduleInfo': scheduleInfo?.toMap(),
    };
  }

  factory ScheduleDetailEntity.fromJson(Map<String, dynamic> map) {
    return ScheduleDetailEntity(
      id: map['id'] as String,
      scheduleId: map['scheduleId'] as String,
      startPeriod: map['startPeriod'] as String,
      endPeriod: map['endPeriod'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      startPeriodTimestamp: map['startPeriodTimestamp'] as int,
      endPeriodTimestamp: map['endPeriodTimestamp'] as int,
      scheduleInfo: map['scheduleInfo'] != null
          ? ScheduleInfoEntity.fromJson(
              map['scheduleInfo'] as Map<String, dynamic>)
          : null,
    );
  }
}
