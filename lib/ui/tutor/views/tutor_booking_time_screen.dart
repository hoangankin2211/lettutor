import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_detail_state.dart';
import 'package:lettutor/ui/tutor/views/widgets/booking_dialog.dart';

import '../blocs/tutor_detail_bloc.dart';
import 'widgets/booking_item.dart';

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

  Widget _buildEmptyAlert() {
    return Center(
      child: Text(context.l10n.emptyAlert, style: context.textTheme.bodyLarge),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TutorDetailBloc, TutorDetailState>(
      bloc: tutorDetailBloc,
      listener: (context, state) {
        if (state is BookClassFailed) {
          context.showSnackBarAlert(state.message);
        } else if (state is BookClassSuccess) {
          context.showSnackBarAlert("Book class success");
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
              context.l10n.tutorFreeBookingTime,
              style: context.textTheme.titleLarge?.boldTextTheme
                  .copyWith(color: context.colorScheme.onPrimary),
            ),
          ),
          body: switch (tutorState) {
            (TutorDetailState state)
                when state is LoadingFreeBooking && !state.isFetching =>
              const AppLoadingIndicator(),
            _ => Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      width: context.width,
                      child: ElevatedBorderButton(
                        onPressed: onTapBooking,
                        borderColor: context.colorScheme.primary,
                        child: Text(
                          "${DateFormat().add_yMEd().format(from)}  -  ${DateFormat().add_yMEd().format(to)}",
                          style: context.textTheme.bodyLarge?.boldTextTheme
                              .copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    if (tutorState.data.bookingTime.isEmpty)
                      _buildEmptyAlert()
                    else
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async =>
                              tutorDetailBloc.getTutorFreeBooking(
                            from,
                            to,
                            isFetching: true,
                          ),
                          child: tutorState.isFetchingList()
                              ? const AppLoadingIndicator()
                              : ListView.separated(
                                  controller: scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  addAutomaticKeepAlives: true,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final schedule =
                                        tutorState.data.bookingTime[index];
                                    return BookingItem(
                                      isBooked: schedule.isBooked,
                                      onTapBookButton: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => BlocBuilder<
                                              TutorDetailBloc,
                                              TutorDetailState>(
                                            bloc: tutorDetailBloc,
                                            builder: (context, state) =>
                                                BookingDialog(
                                              isLoading:
                                                  state.isBooking(schedule.id),
                                              from: schedule.startTimestamp,
                                              to: schedule.endTimestamp,
                                              time: DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                schedule.startTimestamp,
                                              ),
                                              onPressedBook:
                                                  (context, note) async {
                                                return tutorDetailBloc
                                                    .bookTutor(
                                                  scheduleId: schedule.id,
                                                  scheduleDetailIds: schedule
                                                      .scheduleDetails
                                                      .map((e) => e.id)
                                                      .toList(),
                                                  note: note,
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      isLoading: tutorState is BookingClass &&
                                          tutorState.scheduleId == schedule.id,
                                      from: schedule.startTime,
                                      to: schedule.endTime,
                                      time: DateTime.fromMillisecondsSinceEpoch(
                                          schedule.startTimestamp),
                                    );
                                  },
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 15),
                                  itemCount: tutorState.data.bookingTime.length,
                                ),
                        ),
                      )
                  ]
                      .expand<Widget>(
                          (element) => [const SizedBox(height: 10), element])
                      .toList(),
                ),
              ),
          },
        );
      },
    );
  }
}
