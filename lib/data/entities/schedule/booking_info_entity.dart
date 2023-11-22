// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:lettutor/data/entities/schedule/history_feedback_entity.dart';
import 'package:lettutor/data/entities/schedule/schedule_detail_entity.dart';

class BookingInfoEntity {
  final String id;
  final String? userId;
  final String? scheduleId;
  final String? cancelReasonId;
  final int? lessonPlanId;
  final String? calendarId;
  final String? cancelNote;
  final bool? isDeleted;
  final bool? isTrial;
  final int? convertedLesson;
  final String? tutorMeetingLink;
  final String? studentMeetingLink;
  final String? googleMeetLink;
  final String? studentRequest;
  final String? tutorReview;
  final String? scoreByTutor;
  final String? recordUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? createdAtTimeStamp;
  final int? updatedAtTimeStamp;
  final ScheduleDetailEntity? scheduleDetailInfo;
  final bool? showRecordUrl;
  final List<dynamic>? studentMaterials;
  final List<HistoryFeedbackEntity>? feedbacks;

  BookingInfoEntity({
    required this.id,
    this.userId,
    this.scheduleId,
    this.cancelReasonId,
    this.lessonPlanId,
    this.calendarId,
    this.cancelNote,
    this.isDeleted,
    this.isTrial,
    this.convertedLesson,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.googleMeetLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.recordUrl,
    this.createdAt,
    this.updatedAt,
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.scheduleDetailInfo,
    this.showRecordUrl,
    this.studentMaterials,
    this.feedbacks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'scheduleId': scheduleId,
      'cancelReasonId': cancelReasonId,
      'lessonPlanId': lessonPlanId,
      'calendarId': calendarId,
      'cancelNote': cancelNote,
      'isDeleted': isDeleted,
      'isTrial': isTrial,
      'convertedLesson': convertedLesson,
      'tutorMeetingLink': tutorMeetingLink,
      'studentMeetingLink': studentMeetingLink,
      'googleMeetLink': googleMeetLink,
      'studentRequest': studentRequest,
      'tutorReview': tutorReview,
      'scoreByTutor': scoreByTutor,
      'recordUrl': recordUrl,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'createdAtTimeStamp': createdAtTimeStamp,
      'updatedAtTimeStamp': updatedAtTimeStamp,
      'scheduleDetailInfo': scheduleDetailInfo?.toMap(),
    };
  }

  factory BookingInfoEntity.fromJson(Map<String, dynamic> map) {
    return BookingInfoEntity(
      id: map['id'] as String,
      userId: map['userId'] != null ? map['userId'] as String : null,
      scheduleId:
          map['scheduleId'] != null ? map['scheduleId'] as String : null,
      cancelReasonId: map['cancelReasonId'] != null
          ? map['cancelReasonId'] as String
          : null,
      lessonPlanId:
          map['lessonPlanId'] != null ? map['lessonPlanId'] as int : null,
      calendarId:
          map['calendarId'] != null ? map['calendarId'] as String : null,
      cancelNote:
          map['cancelNote'] != null ? map['cancelNote'] as String : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      isTrial: map['isTrial'] != null ? map['isTrial'] as bool : null,
      convertedLesson:
          map['convertedLesson'] != null ? map['convertedLesson'] as int : null,
      tutorMeetingLink: map['tutorMeetingLink'] != null
          ? map['tutorMeetingLink'] as String
          : null,
      studentMeetingLink: map['studentMeetingLink'] != null
          ? map['studentMeetingLink'] as String
          : null,
      googleMeetLink: map['googleMeetLink'] != null
          ? map['googleMeetLink'] as String
          : null,
      studentRequest: map['studentRequest'] != null
          ? map['studentRequest'] as String
          : null,
      tutorReview:
          map['tutorReview'] != null ? map['tutorReview'] as String : null,
      scoreByTutor:
          map['scoreByTutor'] != null ? map['scoreByTutor'] as String : null,
      recordUrl: map['recordUrl'] != null ? map['recordUrl'] as String : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      createdAtTimeStamp: map['createdAtTimeStamp'] != null
          ? map['createdAtTimeStamp'] as int
          : null,
      updatedAtTimeStamp: map['updatedAtTimeStamp'] != null
          ? map['updatedAtTimeStamp'] as int
          : null,
      scheduleDetailInfo: map['scheduleDetailInfo'] != null
          ? ScheduleDetailEntity.fromJson(
              map['scheduleDetailInfo'] as Map<String, dynamic>)
          : null,
      feedbacks: map['feedbacks'] != null
          ? List<dynamic>.of(map['feedbacks'])
              .map<HistoryFeedbackEntity>(
                (e) => HistoryFeedbackEntity.fromJson(e),
              )
              .toList()
          : null,
      showRecordUrl: map['showRecordUrl'] as bool? ?? false,
      studentMaterials: map['studentMaterials'] as List<dynamic>?,
    );
  }
}
