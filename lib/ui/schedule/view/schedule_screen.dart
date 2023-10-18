import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/components/widgets/infinity_scroll_view.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/domain/mapper/tutor_mapper.dart';
import 'package:lettutor/ui/course/views/widgets/course_search_bar.dart';
import 'package:lettutor/ui/schedule/bloc/schedule_bloc.dart';
import 'package:lettutor/ui/schedule/view/widgets/schedule_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with AutomaticKeepAliveClientMixin {
  late final scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    scheduleBloc.fetchScheduleList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      bloc: scheduleBloc,
      builder: (context, scheduleState) {
        return Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: GestureDetector(
              onTap: scheduleBloc.fetchScheduleList,
              child: Text(
                'Schedule',
                style: context.textTheme.titleLarge?.boldTextTheme,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CourseSearchBar(controller: searchController),
                const SizedBox(height: 20),
                Expanded(
                  child: scheduleState is ScheduleLoading ||
                          scheduleState is ScheduleInitial
                      ? const Center(child: AppLoadingIndicator())
                      : RefreshIndicator(
                          onRefresh: scheduleBloc.fetchScheduleList,
                          child: DefaultPagination<BookingInfoEntity>(
                            listenScrollBottom: scheduleBloc.loadMoreSchedule,
                            page: scheduleState.data.page,
                            totalPage: scheduleState.data.totalPage,
                            itemBuilder: (context, index) {
                              final schedule =
                                  scheduleState.data.schedules[index];
                              return ScheduleWidget(
                                tutor: TutorMapper.fromTutorEntity(schedule
                                    .scheduleDetailInfo!
                                    .scheduleInfo!
                                    .tutorInfo),
                                numberLesson: 3,
                                startTime: DateFormat().add_Hm().format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          schedule.scheduleDetailInfo!
                                              .startPeriodTimestamp),
                                    ),
                                endTime: DateFormat().add_Hm().format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          schedule.scheduleDetailInfo!
                                              .endPeriodTimestamp),
                                    ),
                                time: DateTime.fromMillisecondsSinceEpoch(
                                    schedule.scheduleDetailInfo!
                                        .startPeriodTimestamp),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            items: scheduleState.data.schedules,
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
