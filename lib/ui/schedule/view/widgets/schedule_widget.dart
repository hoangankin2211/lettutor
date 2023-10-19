import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_info_header.dart';

import '../../../../domain/models/tutor/tutor.dart';

class ScheduleWidget extends StatefulWidget {
  final DateTime time;
  final int numberLesson;
  final Tutor tutor;
  final String startTime;
  final String endTime;
  final String studentRequest;

  const ScheduleWidget({
    super.key,
    required this.time,
    required this.numberLesson,
    required this.tutor,
    required this.startTime,
    required this.endTime,
    required this.studentRequest,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                "Go to meeting",
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: context.colorScheme.primary),
              ),
              onPressed: () {},
            ),
          ),
        ]
            .expand<Widget>((element) => [
                  element,
                  const SizedBox(
                    height: 10,
                  )
                ])
            .toList(),
      ),
    );
  }

  Widget _buildTimeInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat().add_yMMMEd().format(widget.time),
          style: context.textTheme.titleLarge?.boldTextTheme,
        ),
        Text(
          "${widget.numberLesson} lesson",
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildTutorHeader() {
    return TutorInfoHeader(
      radius: 30,
      avatar: widget.tutor.avatar,
      name: widget.tutor.name,
      numOfFeedback: 100,
      country: widget.tutor.country,
      profession: "English Teacher",
    );
  }

  Widget _buildScheduleInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                icon: Icon(
                  Icons.cancel,
                  color: context.colorScheme.error,
                ),
                label: Text(
                  "Cancel",
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: context.colorScheme.error),
                ),
                onPressed: () {},
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
                  "Request For Lesson",
                  style: context.textTheme.bodyLarge?.boldTextTheme,
                ),
                const Spacer(),
                TextButton(
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
              child: Text(widget.studentRequest),
            ),
          ),
        ],
      ),
    );
  }
}
