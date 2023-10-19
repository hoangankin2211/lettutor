import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/components/widgets/infinity_scroll_view.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/domain/mapper/tutor_mapper.dart';
import 'package:lettutor/ui/course/views/course_detail_screen.dart';
import 'package:lettutor/ui/course/views/widgets/course_search_bar.dart';
import 'package:lettutor/ui/schedule/bloc/schedule_bloc.dart';
import 'package:lettutor/ui/schedule/view/widgets/schedule_widget.dart';

class CustomPreferredSizeWidget extends SizeTransition
    implements PreferredSizeWidget {
  final Size preferredSizeWidget;

  const CustomPreferredSizeWidget({
    super.key,
    required this.preferredSizeWidget,
    required super.child,
    required super.sizeFactor,
  });

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _CustomPreferredSizeWidgetState extends State<CustomPreferredSizeWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController animationController;

  @override
  void initState() {
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
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: widget.child,
    );
  }
}

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
    scheduleBloc.fetchScheduleList();
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
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      bloc: scheduleBloc,
      builder: (context, scheduleState) {
        return Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          appBar: AppBar(
            toolbarHeight: context.height * 0.1,
            elevation: 0,
            centerTitle: true,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: Row(
              children: [
                SvgPicture.asset("assets/images/schedule_icon.svg"),
                const SizedBox(width: 10),
                Text(
                  'Schedule',
                  style: context.textTheme.headlineMedium?.boldTextTheme
                      .copyWith(color: context.textTheme.bodyLarge?.color),
                ),
                IconButton(
                  onPressed: () {
                    isExtend.value = !isExtend.value;
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
            // bottom: PreferredSize(
            //   preferredSize:
            //       Size.fromHeight(value ? context.height * 0.1 : 0),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 18),
            //     child: Text(
            //       "Here is a list of the sessions you have booked\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours",
            //       style: context.textTheme.titleLarge?.copyWith(
            //         color: context.theme.hintColor,
            //         fontSize: 18,
            //       ),
            //     ),
            //   ),
            // ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
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
                                isCanceling: scheduleState is CancelingSchedule,
                                cancelSchedule: () {
                                  scheduleBloc.cancelSchedule([schedule.id]);
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
