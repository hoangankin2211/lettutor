import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';

class BookingDialog extends StatefulWidget {
  const BookingDialog({
    super.key,
    required this.from,
    required this.to,
    required this.time,
    this.isLoading = false,
    this.onPressedBook,
  });
  final bool isLoading;
  final int from;
  final int to;
  final DateTime time;
  final Future<bool> Function(BuildContext context, String note)? onPressedBook;

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  String formatDateTimeRange(DateTime from, DateTime to) {
    String pattern = 'HH:mm';

    String formattedFromDate = DateFormat(pattern).format(from);
    String formattedToDate = DateFormat(pattern).format(to);

    return '$formattedFromDate - $formattedToDate\n${DateFormat("EEEE, dd MMMM yyyy").format(widget.time)}';
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: context.height * 0.8,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BookingHeader(
                  onClose: context.pop,
                ),
                Divider(
                  color: context.theme.dividerColor,
                  height: 0,
                  thickness: 0.5,
                ),
                BookingDialogField(
                  title: Text(
                    "Booking Time",
                    style: context.textTheme.bodyLarge?.boldTextTheme,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        formatDateTimeRange(
                          DateTime.fromMillisecondsSinceEpoch(widget.from),
                          DateTime.fromMillisecondsSinceEpoch(widget.to),
                        ),
                        style:
                            context.textTheme.bodyLarge?.boldTextTheme.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                BookingDialogField(
                  title: Text(
                    "Balance",
                    style: context.textTheme.bodyLarge?.boldTextTheme,
                  ),
                  trailing: Text(
                    "9576 lessons left",
                    style: context.textTheme.bodyLarge?.boldTextTheme.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                BookingDialogField(
                  title: Text(
                    "Price",
                    style: context.textTheme.bodyLarge?.boldTextTheme,
                  ),
                  trailing: Text(
                    "1 lesson",
                    style: context.textTheme.bodyLarge?.boldTextTheme.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                BookingDialogField(
                  title: Text(
                    "Note",
                    style: context.textTheme.bodyLarge?.boldTextTheme,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: "Enter your note",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: context.colorScheme.onSurface
                                  .withOpacity(0.1),
                              width: 0.8,
                            )),
                      ),
                    ),
                  ),
                ),
                ElevatedBorderButton(
                  backgroundColor: context.colorScheme.primary,
                  width: double.infinity,
                  onPressed: () {
                    widget.onPressedBook!(context, textEditingController.text)
                        .then((value) => context.pop());
                  },
                  child: widget.isLoading
                      ? AppLoadingIndicator(
                          color: context.colorScheme.onPrimary,
                          radius: 10,
                        )
                      : Text(
                          "Book",
                          style: context.textTheme.bodyLarge?.boldTextTheme
                              .copyWith(
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                ),
              ]
                  .expand((element) => [element, const SizedBox(height: 10)])
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class BookingHeader extends StatelessWidget {
  const BookingHeader({super.key, required this.onClose});
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Booking Details",
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: onClose,
          icon: Icon(Icons.close, color: context.colorScheme.error),
        ),
      ],
    );
  }
}

class BookingDialogField extends StatelessWidget {
  const BookingDialogField(
      {super.key, required this.title, this.trailing, this.body});
  final Widget title;
  final Widget? trailing;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: context.colorScheme.onSurface.withOpacity(0.1),
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            color: context.theme.secondaryHeaderColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title,
                if (trailing != null) trailing!,
              ],
            ),
          ),
          Divider(
            color: context.colorScheme.onSurface.withOpacity(0.1),
            height: 0,
            thickness: 0.2,
          ),
          Center(child: (body != null) ? body! : Container()),
        ],
      ),
    );
  }
}
