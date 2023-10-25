import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/components/widgets/elevated_border_button.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_bloc.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_detail_state.dart';

import '../blocs/tutor_detail_bloc.dart';

class TutorBookingTimeScreen extends StatefulWidget {
  const TutorBookingTimeScreen({
    super.key,
    required this.tutorDetailBloc,
  });

  final TutorDetailBloc tutorDetailBloc;

  @override
  State<TutorBookingTimeScreen> createState() => _TutorBookingTimeScreenState();
}

class _TutorBookingTimeScreenState extends State<TutorBookingTimeScreen> {
  DateTime from = DateTime.now();
  DateTime to = DateTime.now().add(const Duration(days: 7));

  late final tutorDetailBloc = widget.tutorDetailBloc;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tutorDetailBloc.getTutorFreeBooking(from, to);
  }

  void onTapBooking() {
    showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, DateTime.december, 31),
    ).then((value) {
      if (value != null) {
        setState(() {
          from = value.start;
          to = value.end;
        });
        tutorDetailBloc.getTutorFreeBooking(from, to);
        scrollController.jumpTo(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TutorDetailBloc, TutorDetailState>(
      bloc: tutorDetailBloc,
      listener: (context, state) {
        if (state is BookClassFailed) {
          context.showSnackBarAlert(state.message);
        }
      },
      buildWhen: (previous, current) => !current.isMainState,
      builder: (context, tutorState) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              splashRadius: 30,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: context.colorScheme.onBackground,
              ),
              onPressed: context.pop,
            ),
            title: Text(
              "Tutor Free Booking Time",
              style: context.textTheme.titleLarge?.boldTextTheme
                  .copyWith(color: context.colorScheme.onPrimary),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                width: context.width,
                child: ElevatedBorderButton(
                  onPressed: onTapBooking,
                  borderColor: context.colorScheme.primary,
                  child: Text(
                    "${DateFormat().add_yMEd().format(from)}  -  ${DateFormat().add_yMEd().format(to)}",
                    style: context.textTheme.bodyLarge?.boldTextTheme.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final schedule = tutorState.data.bookingTime[index];
                    return BookingItem(
                      onTapBookButton: (note) => tutorDetailBloc.bookTutor(
                        scheduleId: schedule.id,
                        note: note,
                      ),
                      isLoading: tutorState is BookingClass &&
                          tutorState.scheduleId == schedule.id,
                      from: schedule.startTime,
                      to: schedule.endTime,
                      time: DateTime.fromMillisecondsSinceEpoch(
                          schedule.startTimestamp),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  itemCount: tutorState.data.bookingTime.length,
                ),
              )
            ]
                .expand<Widget>(
                    (element) => [const SizedBox(height: 10), element])
                .toList(),
          ),
        );
      },
    );
  }
}

class BookingItem extends StatelessWidget {
  const BookingItem({
    super.key,
    required this.time,
    required this.from,
    required this.to,
    this.onTapBookButton,
    this.isLoading = false,
  });

  final DateTime time;
  final String from;
  final String to;
  final void Function(String)? onTapBookButton;
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
                      "Date:  ",
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
                    Text("From:", style: titleMedium?.boldTextTheme),
                    const SizedBox(width: 5),
                    Text(from, style: bodyLarge),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_right_alt,
                      color: context.colorScheme.primary,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text("To:", style: titleMedium?.boldTextTheme),
                    const SizedBox(width: 5),
                    Text(to, style: bodyLarge),
                  ],
                ),
              ],
            ),
            ElevatedBorderButton(
              onPressed: () {
                if (onTapBookButton != null) {
                  onTapBookButton!("");
                }
              },
              child: isLoading
                  ? const AppLoadingIndicator(radius: 5)
                  : Text(
                      "Book",
                      style:
                          context.textTheme.bodyLarge?.boldTextTheme.copyWith(
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