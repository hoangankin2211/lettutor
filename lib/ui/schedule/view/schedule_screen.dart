import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:lettutor/core/constants/ui_config.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/utils/analytics/google_analytic_service.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/navigation/routes_location.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/utils/widgets/custom_appbar.dart';
import 'package:lettutor/core/utils/widgets/custom_stack_scroll.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';
import 'package:lettutor/core/utils/widgets/infinity_scroll_view.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/domain/mapper/tutor_mapper.dart';
import 'package:lettutor/domain/models/user.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/dashboard/blocs/dashboard_bloc.dart';
import 'package:lettutor/ui/schedule/bloc/schedule_bloc.dart';
import 'package:lettutor/ui/schedule/view/widgets/schedule_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  ScheduleBloc get _scheduleBloc => BlocProvider.of<ScheduleBloc>(context);

  final GoogleAnalyticService _analyticService =
      injector.get<GoogleAnalyticService>();
  User? get _user => BlocProvider.of<AuthenticationBloc>(context).state.user;

  late final Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceIn,
    );

    super.initState();
  }

  void _joinMeeting(String meetingUrl) async {
    final meetingToken = meetingUrl.split('token=')[1];
    if (meetingToken.isNotEmpty) {
      Map<String, Object> featureFlags = {};
      try {
        var options = JitsiMeetingOptions(
          roomNameOrUrl: "learningRoom",
          serverUrl: "https://meet.lettutor.com",
          token: meetingToken,
          isAudioMuted: false,
          isAudioOnly: false,
          isVideoMuted: false,
          userDisplayName: _user?.name ?? '',
          userEmail: _user?.email ?? '',
          userAvatarUrl: _user?.avatar ?? "",
          featureFlags: featureFlags,
        );

        await JitsiMeetWrapper.joinMeeting(options: options);
      } catch (e) {
        logger.d(e.toString());
      }
    }
  }

  String _formatTimestamp(int timestamp) {
    return DateFormat()
        .add_Hm()
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  void _eventListenerHandler(
      BuildContext context, ScheduleState scheduleState) {
    switch (scheduleState.runtimeType) {
      case ScheduleError:
        context.showSnackBarAlert((scheduleState as ScheduleError).message);
      case CancelScheduleFailed:
        context
            .showSnackBarAlert((scheduleState as CancelScheduleFailed).message);
      case EditRequestFailed:
        context.showSnackBarAlert((scheduleState as EditRequestFailed).message);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      bloc: _scheduleBloc,
      listener: _eventListenerHandler,
      builder: (context, scheduleState) {
        return Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
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
                                context.l10n.schedule,
                                style: context
                                    .textTheme.headlineMedium?.boldTextTheme
                                    .copyWith(
                                        color:
                                            context.textTheme.bodyLarge?.color),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (_animation.status ==
                                      AnimationStatus.completed) {
                                    _animationController.reverse();
                                  } else {
                                    _animationController.forward();
                                  }
                                },
                                constraints: UiConfig.emptyBoxConstraints,
                                splashRadius: 30,
                                icon:
                                    const Icon(Icons.arrow_drop_down, size: 30),
                              ),
                            ],
                          ),
                          Flexible(
                            child: SizeTransition(
                              sizeFactor: _animation,
                              axis: Axis.vertical,
                              child: Text(
                                context.l10n.scheduleScreenTitle,
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
                  child: scheduleState.isLoading
                      ? const Center(child: AppLoadingIndicator())
                      : RefreshIndicator(
                          onRefresh: _scheduleBloc.fetchScheduleList,
                          child: scheduleState.data.schedules.isEmpty
                              ? CustomTemplateScreenStackScroll(
                                  appBar: const AppBarCustom(
                                    height: 0,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  children: [
                                    SliverToBoxAdapter(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: context.theme.hintColor
                                                .withOpacity(0.5),
                                            size: 100,
                                          ),
                                          Center(
                                            child: Text(
                                              "No schedule",
                                              style: context
                                                  .textTheme
                                                  .headlineMedium
                                                  ?.boldTextTheme,
                                            ),
                                          ),
                                          ElevatedBorderButton(
                                            width: context.width * 0.5,
                                            onPressed: () {
                                              context
                                                  .read<DashboardBloc>()
                                                  .changeTab(1);
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  color: context
                                                      .theme.primaryColor,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "${context.l10n.book} now",
                                                  style: context
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: context.theme
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : DefaultPagination<BookingInfoEntity>(
                                  listenScrollBottom:
                                      _scheduleBloc.loadMoreSchedule,
                                  page: scheduleState.data.page,
                                  totalPage: scheduleState.data.totalPage,
                                  itemBuilder: (context, index) {
                                    final schedule =
                                        scheduleState.data.schedules[index];
                                    return ValueListenableBuilder<String>(
                                      valueListenable:
                                          schedule.studentRequestController,
                                      builder: (context, request, child) =>
                                          ScheduleWidget(
                                        scheduleId: schedule.id,
                                        editRequest: (request) {
                                          _scheduleBloc.editRequest(schedule.id,
                                              schedule.id, request);
                                        },
                                        openMeeting: () {
                                          if (schedule.studentMeetingLink !=
                                              null) {
                                            // _analyticService.sendEvent(
                                            //     AnalyticEvent.attendCourse.name,
                                            //     {
                                            //       "tutor_id": schedule
                                            //           .scheduleDetailInfo!
                                            //           .scheduleInfo!
                                            //           .tutorInfo
                                            //           .id,
                                            //       "tutor_name": schedule
                                            //           .scheduleDetailInfo!
                                            //           .scheduleInfo!
                                            //           .tutorInfo
                                            //           .name,
                                            //       "schedule_id": schedule.id,
                                            //     });

                                            _joinMeeting(
                                                schedule.studentMeetingLink!);
                                          }
                                        },
                                        isEditing: scheduleState
                                            .isEditing(schedule.id),
                                        isCanceling: scheduleState
                                            .isCanceling(schedule.id),
                                        cancelSchedule: () {
                                          _scheduleBloc
                                              .cancelSchedule(schedule.id);
                                        },
                                        studentRequest: request,
                                        tutor: TutorMapper.fromTutorEntity(
                                            schedule.scheduleDetailInfo!
                                                .scheduleInfo!.tutorInfo),
                                        numberLesson: 3,
                                        startTime: _formatTimestamp(schedule
                                            .scheduleDetailInfo!
                                            .startPeriodTimestamp),
                                        endTime: _formatTimestamp(schedule
                                            .scheduleDetailInfo!
                                            .endPeriodTimestamp),
                                        time:
                                            DateTime.fromMillisecondsSinceEpoch(
                                                schedule.scheduleDetailInfo!
                                                    .startPeriodTimestamp),
                                      ),
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
