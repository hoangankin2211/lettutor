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

  const ScheduleWidget({
    super.key,
    required this.time,
    required this.numberLesson,
    required this.tutor,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  final ValueNotifier<double> size = ValueNotifier(100);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.theme.hintColor.withOpacity(0.05),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimeInfo(),
          _buildTutorHeader(),
          _buildScheduleInfo(),
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
          style: context.textTheme.titleSmall,
        ),
      ],
    );
  }

  Widget _buildTutorHeader() {
    return TutorInfoHeader(
      avatar: widget.tutor.avatar,
      name: widget.tutor.name,
      numOfFeedback: 100,
      country: widget.tutor.country,
      profession: widget.tutor.profession,
    );
  }

  Widget _buildScheduleInfo() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.startTime} - ${widget.endTime}"),
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
          // SizeTransition(
          //   sizeFactor: Animation.fromValueListenable(size),
          //   axis: Axis.vertical,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       InkWell(
          //         onTap: () {
          //           size.value = 200;
          //         },
          //         child: Row(
          //           children: [
          //             Icon(
          //               Icons.arrow_drop_down_sharp,
          //               color: context.theme.disabledColor,
          //             ),
          //             Text(
          //               "Request For Lesson",
          //               style: context.textTheme.bodyLarge?.boldTextTheme,
          //             ),
          //             const Spacer(),
          //             TextButton(
          //               onPressed: () {},
          //               child: Text(
          //                 "Edit",
          //                 style: context.textTheme.bodyLarge
          //                     ?.copyWith(color: context.colorScheme.primary),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
