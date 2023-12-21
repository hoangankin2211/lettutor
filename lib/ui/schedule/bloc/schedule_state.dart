// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'schedule_bloc.dart';

abstract class ScheduleState {
  final ScheduleData data;

  bool get isLoading => this is ScheduleLoading || this is ScheduleInitial;

  bool isEditing(String scheduleId) =>
      this is EditingRequest &&
      (this as EditingRequest).scheduleId == scheduleId;

  bool isCanceling(String scheduleId) =>
      this is CancelingSchedule &&
      (this as CancelingSchedule).scheduleId == scheduleId;

  ScheduleState({required this.data});
}

class ScheduleInitial extends ScheduleState {
  ScheduleInitial({super.data = const ScheduleData()});
}

class ScheduleLoading extends ScheduleState {
  ScheduleLoading({required super.data});
}

class ScheduleLoaded extends ScheduleState {
  ScheduleLoaded({required super.data});
}

class EditRequestSuccess extends ScheduleState {
  final String scheduleId;
  EditRequestSuccess({
    required super.data,
    required this.scheduleId,
  });
}

class EditRequestFailed extends ScheduleState {
  final String message;
  EditRequestFailed({required super.data, required this.message});
}

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError({required this.message, required super.data});
}

class CancelingSchedule extends ScheduleState {
  final String scheduleId;
  CancelingSchedule({
    required super.data,
    required this.scheduleId,
  });
}

class EditingRequest extends ScheduleState {
  final String scheduleId;
  EditingRequest({
    required super.data,
    required this.scheduleId,
  });
}

class CancelScheduleSuccess extends ScheduleState {
  CancelScheduleSuccess({required super.data});
}

class CancelScheduleFailed extends ScheduleState {
  final String message;

  CancelScheduleFailed({required super.data, required this.message});
}

class ScheduleData {
  final int page;
  final int perPage;
  final int count;
  final List<BookingInfoEntity> schedules;

  int get totalPage => (count.toDouble() / perPage).ceil();

  const ScheduleData({
    this.page = 1,
    this.count = 0,
    this.perPage = 10,
    this.schedules = const [],
  });

  ScheduleData copyWith({
    int? page,
    int? perPage,
    int? count,
    List<BookingInfoEntity>? schedules,
  }) {
    return ScheduleData(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      count: count ?? this.count,
      schedules: schedules ?? this.schedules,
    );
  }
}
