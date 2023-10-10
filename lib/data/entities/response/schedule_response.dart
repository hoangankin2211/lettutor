// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../schedule/schedule_entity.dart';

class ScheduleResponse {
  final String status;
  final List<ScheduleEntity> schedules;
  ScheduleResponse(this.status, this.schedules);

  factory ScheduleResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['scheduleOfTutor'];
    if (cData == null) return ScheduleResponse('Error', List.empty());
    return ScheduleResponse(
      data['message']?.toString() ?? 'Error',
      ((cData) as List<dynamic>)
          .map((e) => ScheduleEntity.fromJson(e))
          .toList(),
    );
  }
}
