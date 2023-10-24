import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
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

  @override
  void initState() {
    super.initState();
    tutorDetailBloc.getTutorFreeBooking(from, to);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutorDetailBloc, TutorDetailState>(
      bloc: tutorDetailBloc,
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
              ElevatedBorderButton(
                onPressed: () {},
                borderColor: context.colorScheme.primary,
                child: Text(
                  "${DateFormat().add_yMMMMEEEEd().format(from)} - ${DateFormat().add_yMMMMEEEEd().format(to)}",
                  style: context.textTheme.bodyLarge?.boldTextTheme.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final schedule = tutorState.data.bookingTime[index];
                    return BookingItem(
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
            ],
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
  });

  final DateTime time;
  final String from;
  final String to;

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
                      "Date: ",
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
              onPressed: () {},
              child: Text(
                "Book",
                style: context.textTheme.bodyLarge?.boldTextTheme.copyWith(
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
