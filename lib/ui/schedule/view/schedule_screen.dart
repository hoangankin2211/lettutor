import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/core/components/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/components/widgets/infinity_scroll_view.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/domain/mapper/tutor_mapper.dart';
import 'package:lettutor/ui/schedule/bloc/schedule_bloc.dart';
import 'package:lettutor/ui/schedule/view/widgets/schedule_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late final scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
  final ValueNotifier<bool> isExtend = ValueNotifier(false);
  final TextEditingController searchController = TextEditingController();

  late final Animation<double> animation;
  late final AnimationController animationController;

  @override
  void initState() {
    // scheduleBloc.fetchScheduleList();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceIn,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      bloc: scheduleBloc,
      listener: (context, state) {
        if (state is ScheduleError) {
          context.showSnackBarAlert(state.message);
        }
        if (state is CancelScheduleFailed) {
          context.showSnackBarAlert(state.message);
        }
      },
      builder: (context, scheduleState) {
        return Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          // appBar: AppBar(
          //   toolbarHeight: context.height * 0.1,
          //   elevation: 0,
          //   centerTitle: true,
          //   backgroundColor: context.theme.scaffoldBackgroundColor,
          //   title:
          // ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/schedule_icon.svg"),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Schedule',
                                style: context
                                    .textTheme.headlineMedium?.boldTextTheme
                                    .copyWith(
                                        color:
                                            context.textTheme.bodyLarge?.color),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (animation.status ==
                                      AnimationStatus.completed) {
                                    animationController.reverse();
                                  } else {
                                    animationController.forward();
                                  }
                                },
                                constraints: const BoxConstraints(),
                                splashRadius: 30,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: SizeTransition(
                              sizeFactor: animation,
                              axis: Axis.vertical,
                              child: Text(
                                "Here is a list of the sessions you have booked\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours",
                                style: context.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
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
                                openMeeting: () {
                                  context.push(RouteLocation.meeting, extra: {
                                    "meetingUrl": schedule.studentMeetingLink
                                  });
                                },
                                isCanceling:
                                    scheduleState is CancelingSchedule &&
                                        scheduleState.scheduleId == schedule.id,
                                cancelSchedule: () {
                                  scheduleBloc.cancelSchedule(schedule.id);
                                },
                                studentRequest: schedule.studentRequest ?? "",
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
