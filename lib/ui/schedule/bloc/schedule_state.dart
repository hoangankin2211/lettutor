// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'schedule_bloc.dart';

abstract class ScheduleState {
  final ScheduleData data;

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

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError({required this.message, required super.data});
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
