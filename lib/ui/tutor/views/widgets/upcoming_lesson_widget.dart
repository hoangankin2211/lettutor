import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/domain/models/user.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class UpComingWidget extends StatefulWidget {
  const UpComingWidget({
    super.key,
    required this.totalLearnTime,
    required this.nextClass,
    required this.user,
  });

  final int totalLearnTime;
  final BookingInfoEntity? nextClass;
  final User? user;

  @override
  State<UpComingWidget> createState() => _UpComingWidgetState();
}

class _UpComingWidgetState extends State<UpComingWidget>
    with SingleTickerProviderStateMixin {
  final CountdownController controller = CountdownController(autoStart: true);
  late final Animation<double> animation;
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  RichText _renderRichText(int hours, int minutes, int? seconds,
      {required String header}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
        children: [
          ...[
            header,
            if (hours > 0) hours.toString(),
            if (hours > 0) ' ${context.l10n.hours} ${context.l10n.and} ',
            minutes.toString(),
            ' ${context.l10n.minutes} ',
            if (seconds != null) ...[
              seconds.toString(),
              ' ${context.l10n.seconds}.'
            ],
          ].asMap().entries.map((entry) {
            final textStyle = TextStyle(
              fontWeight:
                  entry.key % 2 == 0 ? FontWeight.w400 : FontWeight.w600,
              color: entry.key % 2 == 0 ? null : Colors.yellow.shade700,
            );
            return TextSpan(text: entry.value, style: textStyle);
          }),
        ],
      ),
    );
  }

  DateTime parseDateTime(String? dateStr, String? timeStr) {
    if (dateStr == null || timeStr == null) return DateTime.now();
    String combinedDateTimeStr = "$dateStr $timeStr";
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

    return dateFormat.parse(combinedDateTimeStr);
  }

  void _onTapShowMore() {
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
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
          userDisplayName: widget.user?.name ?? '',
          userEmail: widget.user?.email ?? '',
          userAvatarUrl: widget.user?.avatar ?? "",
          featureFlags: featureFlags,
        );

        await JitsiMeetWrapper.joinMeeting(options: options);
      } catch (e) {
        logger.d(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final meetingTime = DateTime.fromMillisecondsSinceEpoch(
        widget.nextClass?.scheduleDetailInfo?.startPeriodTimestamp ??
            DateTime.now().millisecondsSinceEpoch);

    final data = ((widget.totalLearnTime)).round();
    int hours = data ~/ 60;
    int minutes = data % 60;
    return GestureDetector(
      onTap: _onTapShowMore,
      child: Container(
        width: context.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blue.shade700,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.nextClass == null)
              Flexible(
                child: Text(
                  context.l10n.noUpcomingLesson,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              )
            else
              ...([
                Row(
                  children: [
                    const Spacer(flex: 3),
                    Text(
                      context.l10n.upcomingLesson,
                      style: context.textTheme.titleMedium
                          ?.copyWith(
                            color: context.colorScheme.onPrimary,
                          )
                          .boldTextTheme,
                    ),
                    const Spacer(flex: 2),
                    Material(
                      color: Colors.blue.shade700,
                      child: InkWell(
                        onTap: _onTapShowMore,
                        splashColor: Colors.grey,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${DateFormat().add_MMMEd().format(
                            DateFormat("yyyy-MM-dd").parse(widget.nextClass!
                                .scheduleDetailInfo!.scheduleInfo!.date),
                          )}\n${widget.nextClass!.scheduleDetailInfo!.scheduleInfo!.startTime} - ${widget.nextClass!.scheduleDetailInfo!.scheduleInfo!.endTime}",
                      style: context.textTheme.titleMedium
                          ?.copyWith(color: context.colorScheme.onPrimary)
                          .boldTextTheme,
                    ),
                    const SizedBox(width: 20),
                    ElevatedBorderButton(
                      onPressed: () {
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
                            widget.nextClass?.studentMeetingLink ?? "");
                      },
                      backgroundColor: context.theme.cardColor,
                      child: Text(
                        context.l10n.goToMeeting,
                        style: context.textTheme.titleMedium?.boldTextTheme
                            .copyWith(color: context.theme.primaryColor),
                      ),
                    ),
                  ],
                ),
                SizeTransition(
                  axis: Axis.vertical,
                  sizeFactor: animation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Countdown(
                        controller: controller,
                        seconds:
                            meetingTime.difference(DateTime.now()).inSeconds,
                        build: (BuildContext context, double time) {
                          int hours = time.round() ~/ 3600;
                          int minutes = (time.round() % 3600) ~/ 60;
                          int seconds = time.round() % 60;
                          return _renderRichText(
                            hours,
                            minutes,
                            seconds,
                            header: '${context.l10n.nextClassWillBeginIn} \n',
                          );
                        },
                        interval: const Duration(milliseconds: 100),
                        onFinished: () {},
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: _renderRichText(
                          hours,
                          minutes,
                          null,
                          header: "${context.l10n.yourTotalLessonTime} ",
                        ),
                      ),
                    ],
                  ),
                )
              ]).expand<Widget>((element) {
                return [const SizedBox(height: 10), element];
              }),
          ],
        ),
      ),
    );
  }
}
