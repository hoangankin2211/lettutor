import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({
    super.key,
    required this.time,
    required this.from,
    required this.to,
    this.onTapBookButton,
    this.isLoading = false,
    required this.isBooked,
  });

  final DateTime time;
  final String from;
  final String to;
  final bool isBooked;
  final void Function()? onTapBookButton;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final bodyLarge = context.textTheme.bodyLarge;
    final titleMedium = context.textTheme.titleMedium;
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${context.l10n.Date}:  ",
                      style: titleMedium?.boldTextTheme,
                    ),
                    Text(
                      DateFormat().add_yMMMEd().format(time),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${context.l10n.from}:",
                        style: titleMedium?.boldTextTheme),
                    const SizedBox(width: 5),
                    Text(from, style: bodyLarge),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_right_alt,
                      color: context.colorScheme.primary,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text("${context.l10n.to}:",
                        style: titleMedium?.boldTextTheme),
                    const SizedBox(width: 5),
                    Text(to, style: bodyLarge),
                  ],
                ),
              ],
            ),
            ElevatedBorderButton(
              onPressed: isBooked
                  ? null
                  : () {
                      if (onTapBookButton != null) {
                        onTapBookButton!();
                      }
                    },
              backgroundColor: isBooked ? context.colorScheme.primary : null,
              child: isBooked
                  ? Icon(Icons.check, color: context.colorScheme.onPrimary)
                  : isLoading
                      ? const AppLoadingIndicator(radius: 15)
                      : Text(
                          context.l10n.bookTutor,
                          style: context.textTheme.bodyLarge?.boldTextTheme
                              .copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
