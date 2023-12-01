import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/constants/enum.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';
import 'package:lettutor/ui/course/views/course_screen.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({
    super.key,
    this.onDone,
    this.selectedDate,
    this.startTime,
    this.endTime,
    this.selectedTag = TutorTag.All,
    this.national,
  });

  final DateTime? selectedDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final TutorTag? selectedTag;
  final Set<National>? national;

  final void Function(Map<String, dynamic> result)? onDone;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late DateTime? selectedDate = widget.selectedDate;
  late TimeOfDay? startTime = widget.startTime;
  late TimeOfDay? endTime = widget.endTime;
  late TutorTag selectedTag = widget.selectedTag ?? TutorTag.All;
  late final Set<National> national = widget.national ?? {};

  void openCalendar() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      confirmText: context.l10n.select,
      cancelText: context.l10n.cancel,
    ).then((value) {
      setState(() {
        selectedDate = value ?? selectedDate;
      });
    });
  }

  Future<TimeOfDay?> openDateRange(TimeOfDay? startTime) {
    return showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );
  }

  void _onFilter() {
    final nationalMap = <String, bool>{};

    if (national.contains(National.native)) {
      nationalMap.addAll({
        "isNative": true,
      });
    }
    if (national.contains(National.vietnam)) {
      nationalMap.addAll({
        "isVietnamese": true,
      });
    }
    if (national.contains(National.foreign)) {
      nationalMap.clear();
    }

    if (widget.onDone != null) {
      widget.onDone!({
        "national": nationalMap,
        "startTime": startTime != null
            ? DateTime.now()
                .copyWith(
                  hour: startTime?.hour,
                  minute: startTime?.minute,
                )
                .millisecondsSinceEpoch
            : null,
        "endTime": endTime != null
            ? DateTime.now()
                .copyWith(
                  hour: endTime?.hour,
                  minute: endTime?.minute,
                )
                .millisecondsSinceEpoch
            : null,
        "selectedDate": selectedDate,
        "selectedTag": switch (selectedTag.key) {
          null => <String>[],
          _ => <String>[selectedTag.key!],
        },
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.selectTutorNational,
              style: context.textTheme.titleMedium?.boldTextTheme,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 5,
              runSpacing: 4,
              children: [
                for (final tag in National.values)
                  ChoiceChip(
                    selectedColor: context.theme.primaryColor.withOpacity(0.3),
                    label: Text(tag.name),
                    selected: national.contains(tag),
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          national.add(tag);
                        } else {
                          national.remove(tag);
                        }
                      });
                    },
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.selectAvailableTutoringTime,
                  style: context.textTheme.titleMedium?.boldTextTheme,
                ),
                SizedBox(
                  height: 30,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        startTime = null;
                        endTime = null;
                        selectedDate = null;
                      });
                    },
                    child: Text("Clear"),
                  ),
                )
              ],
            ),
            ElevatedButton.icon(
              onPressed: openCalendar,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: context.theme.hintColor, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              icon: Icon(
                Icons.calendar_month,
                color: context.theme.hintColor,
              ),
              label: Text(
                selectedDate == null
                    ? context.l10n.selectDate
                    : DateFormat().add_yMd().format(selectedDate!),
                style: context.textTheme.bodyLarge,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    openDateRange(startTime).then((value) {
                      setState(() {
                        startTime = value ?? startTime;
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      side:
                          BorderSide(color: context.theme.hintColor, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  icon: Icon(
                    Icons.calendar_month,
                    color: context.theme.hintColor,
                  ),
                  label: Text(
                    startTime == null
                        ? context.l10n.selectStartTime
                        : "${startTime!.hour}:${startTime!.minute}",
                    style: context.textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    openDateRange(startTime).then((value) {
                      if (value == null) return;
                      setState(() {
                        endTime = value;
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      side:
                          BorderSide(color: context.theme.hintColor, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  icon: Icon(
                    Icons.calendar_month,
                    color: context.theme.hintColor,
                  ),
                  label: Text(
                    endTime == null
                        ? context.l10n.selectEndTime
                        : "${endTime!.hour}:${endTime!.minute}",
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Text(
              context.l10n.selectTutorTag,
              style: context.textTheme.titleMedium?.boldTextTheme,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 5,
              runSpacing: 4,
              children: [
                for (final tag in TutorTag.values)
                  ChoiceChip(
                    selectedColor: context.theme.primaryColor.withOpacity(0.1),
                    label: Text(tag.name),
                    selected: tag == selectedTag,
                    onSelected: (value) {
                      if (value) {
                        setState(() {
                          selectedTag = tag;
                        });
                      }
                    },
                  ),
              ],
            ),
            Center(
              child: SizedBox(
                width: context.width * 0.9,
                child: ElevatedBorderButton(
                  onPressed: _onFilter,
                  backgroundColor: context.theme.dialogBackgroundColor,
                  borderColor: context.theme.primaryColor,
                  child: Text(
                    "Ok",
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: context.theme.primaryColor),
                  ),
                ),
              ),
            ),
          ]
              .expand<Widget>((element) => [
                    element,
                    if (element is! Text) const SizedBox(height: 20),
                  ])
              .toList(),
        ),
      ),
    );
  }
}
