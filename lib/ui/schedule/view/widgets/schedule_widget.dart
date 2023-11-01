import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_info_header.dart';

import '../../../../domain/models/tutor/tutor.dart';

class ScheduleWidget extends StatefulWidget {
  final DateTime time;
  final int numberLesson;
  final Tutor tutor;
  final String startTime;
  final String endTime;
  final String studentRequest;
  final void Function()? cancelSchedule;
  final void Function()? openMeeting;
  final bool isCanceling;

  const ScheduleWidget({
    super.key,
    this.cancelSchedule,
    required this.time,
    required this.numberLesson,
    required this.tutor,
    required this.startTime,
    required this.endTime,
    required this.studentRequest,
    this.openMeeting,
    this.isCanceling = false,
  });

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: context.theme.dividerColor),
        color: context.colorScheme.onPrimary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimeInfo(),
          _buildTutorHeader(),
          _buildScheduleInfo(),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: context.theme.dividerColor.withOpacity(0.2),
                backgroundColor: context.colorScheme.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side:
                      BorderSide(width: 1, color: context.colorScheme.primary),
                ),
              ),
              icon: Icon(
                Icons.label_important_outlined,
                color: context.colorScheme.primary,
              ),
              label: Text(
                context.l10n.goToMeeting,
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: context.colorScheme.primary),
              ),
              onPressed: widget.openMeeting,
            ),
          ),
        ]
            .expand<Widget>((element) => [element, const SizedBox(height: 10)])
            .toList(),
      ),
    );
  }

  Widget _buildTimeInfo() {
    return TimeInfoField(numberLesson: widget.numberLesson, time: widget.time);
  }

  Widget _buildTutorHeader() {
    return TutorInfoHeader(
      radius: 30,
      avatar: widget.tutor.avatar,
      name: widget.tutor.name,
      numOfFeedback: 100,
      country: widget.tutor.country,
      profession: context.l10n.englishTeacher,
    );
  }

  Widget _buildScheduleInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colorScheme.primary.withOpacity(0.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.startTime} - ${widget.endTime}",
                style: context.textTheme.titleLarge,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: context.theme.dividerColor.withOpacity(0.2),
                  backgroundColor: context.colorScheme.onPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side:
                        BorderSide(width: 1, color: context.colorScheme.error),
                  ),
                ),
                icon: widget.isCanceling
                    ? AppLoadingIndicator(
                        color: context.colorScheme.error,
                        radius: 20,
                      )
                    : Icon(
                        Icons.cancel,
                        color: context.colorScheme.error,
                      ),
                label: Text(
                  context.l10n.cancel,
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: context.colorScheme.error),
                ),
                onPressed: widget.cancelSchedule,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              animation.isCompleted
                  ? animationController.reverse()
                  : animationController.forward();
            },
            child: Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: animation,
                  builder: (context, value, child) => Icon(
                    animation.isCompleted
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: context.theme.disabledColor,
                  ),
                ),
                Text(
                  context.l10n.requestForLesson,
                  style: context.textTheme.bodyLarge?.boldTextTheme,
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {},
                  child: Text(
                    "Edit",
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: context.colorScheme.primary),
                  ),
                )
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: animation,
            axis: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(widget.studentRequest.isEmpty
                  ? context.l10n.historyScreen
                  : widget.studentRequest),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeInfoField extends StatelessWidget {
  const TimeInfoField({
    super.key,
    required this.time,
    required this.numberLesson,
  });
  final DateTime time;
  final int numberLesson;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat().add_yMMMEd().format(time),
          style: context.textTheme.titleMedium?.boldTextTheme,
        ),
        Text(
          "$numberLesson lesson",
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }
}
