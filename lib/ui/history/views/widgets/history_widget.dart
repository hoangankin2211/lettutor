import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/widgets/elevated_border_button.dart';
import 'package:lettutor/core/components/widgets/ratting_widget_custom.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_info_header.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({
    super.key,
    required this.time,
    required this.studentRequest,
    required this.tutorName,
    required this.avatar,
    required this.country,
    required this.startTime,
    required this.endTime,
    required this.ratings,
    this.onTapEdit,
    this.onTapReport,
    this.onTapComment,
    this.onPressedTutorHeader,
  });

  final DateTime time;
  final String studentRequest;
  final String tutorName;
  final String avatar;
  final String country;
  final String startTime;
  final String endTime;
  final List<int> ratings;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapReport;
  final VoidCallback? onTapComment;
  final VoidCallback? onPressedTutorHeader;

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget>
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

  Widget _buildFieldBorder(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colorScheme.primary.withOpacity(0.1),
      ),
      child: child,
    );
  }

  Widget _buildTutorHeader() {
    return TutorInfoHeader(
      onTap: widget.onPressedTutorHeader,
      isShowReview: false,
      radius: 30,
      avatar: widget.avatar,
      name: widget.tutorName,
      numOfFeedback: 100,
      country: widget.country,
      profession: "English Teacher",
    );
  }

  _buildTimeFiled() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat().add_yMMMEd().format(widget.time),
          style: context.textTheme.titleLarge?.boldTextTheme,
        ),
        Text(
          timeago.format(widget.time),
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildRequestField() {
    return _buildFieldBorder(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: animation,
            axis: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(widget.studentRequest.isEmpty
                  ? "Currently there are no requests for this class. Please write down any requests for the teacher."
                  : widget.studentRequest),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewField(int rating) {
    return _buildFieldBorder(Column(
      children: [
        Row(
          children: [
            const Icon(Icons.fact_check),
            const SizedBox(width: 5),
            Text(
              "Rating",
              style: context.textTheme.titleLarge?.boldTextTheme,
            ),
            const Spacer(),
            ElevatedBorderButton(
              onPressed: widget.onTapEdit,
              child: Text(
                "Edit",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.theme.primaryColor.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RattingWidgetCustom(
              rating: rating.toDouble(),
              itemSize: 20,
            ),
            ElevatedBorderButton(
              onPressed: widget.onTapReport,
              borderColor: context.colorScheme.error,
              child: Text(
                "Report",
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: context.colorScheme.error),
              ),
            )
          ],
        )
      ],
    ));
  }

  Widget _buildLessonTimeField() {
    return _buildFieldBorder(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Lesson Time",
          style: context.textTheme.titleMedium?.boldTextTheme,
        ),
        Text(
          "${widget.startTime} - ${widget.endTime}",
          style: context.textTheme.titleMedium,
        )
      ],
    ));
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
        children: [
          _buildTimeFiled(),
          _buildTutorHeader(),
          _buildLessonTimeField(),
          _buildRequestField(),
          if (widget.ratings.isNotEmpty)
            ...widget.ratings.map<Widget>((rating) => _buildReviewField(rating))
          else
            _buildFieldBorder(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: widget.onTapComment,
                    icon: const Icon(Icons.add_comment),
                    label: const Text("Add a Rating"),
                  ),
                  ElevatedBorderButton(
                    onPressed: widget.onTapReport,
                    borderColor: context.colorScheme.error,
                    child: Text(
                      "Report",
                      style: context.textTheme.bodyLarge
                          ?.copyWith(color: context.colorScheme.error),
                    ),
                  )
                ],
              ),
            )
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
}
