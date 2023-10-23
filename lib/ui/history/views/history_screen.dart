import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/ui/history/views/widgets/history_widget.dart';
import 'package:lettutor/ui/schedule/bloc/schedule_bloc.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_info_header.dart';

import '../../../core/components/widgets/infinity_scroll_view.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  final ScheduleBloc scheduleBloc = injector.get<ScheduleBloc>();

  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    scheduleBloc.fetchScheduleList();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    super.initState();
  }

  Widget _buildBody(ScheduleState scheduleState) {
    return Expanded(
      child: scheduleState is ScheduleLoading ||
              scheduleState is ScheduleInitial
          ? const Center(child: AppLoadingIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RefreshIndicator(
                onRefresh: scheduleBloc.fetchScheduleList,
                child: DefaultPagination<BookingInfoEntity>(
                  listenScrollBottom: scheduleBloc.loadMoreSchedule,
                  page: scheduleState.data.page,
                  totalPage: scheduleState.data.totalPage,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  items: scheduleState.data.schedules,
                  itemBuilder: (context, index) {
                    final bookingItem = scheduleState.data.schedules[index];
                    return HistoryWidget(
                      onPressedTutorHeader: () {
                        context.push(RouteLocation.tutorDetail, extra: {
                          "tutorId": bookingItem.scheduleDetailInfo
                              ?.scheduleInfo?.tutorInfo.userId
                        });
                      },
                      onTapComment: () {},
                      onTapEdit: () {},
                      onTapReport: () {},
                      ratings:
                          (bookingItem.feedbacks?.map((e) => e.rating) ?? [])
                              .toList(),
                      time: bookingItem.createdAt ?? DateTime.now(),
                      studentRequest: bookingItem.studentRequest ?? "",
                      tutorName: bookingItem.scheduleDetailInfo?.scheduleInfo
                              ?.tutorInfo.name ??
                          "",
                      avatar: bookingItem.scheduleDetailInfo?.scheduleInfo
                              ?.tutorInfo.avatar ??
                          "",
                      country: bookingItem.scheduleDetailInfo?.scheduleInfo
                              ?.tutorInfo.country ??
                          "",
                      startTime: DateFormat().add_Hm().format(
                            DateTime.fromMillisecondsSinceEpoch(bookingItem
                                .scheduleDetailInfo!.startPeriodTimestamp),
                          ),
                      endTime: DateFormat().add_Hm().format(
                            DateTime.fromMillisecondsSinceEpoch(bookingItem
                                .scheduleDetailInfo!.endPeriodTimestamp),
                          ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      bloc: scheduleBloc,
      builder: (context, scheduleState) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/history_icon.svg",
                    height: 100,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              'History',
                              style: context
                                  .textTheme.headlineMedium?.boldTextTheme
                                  .copyWith(
                                      color:
                                          context.textTheme.bodyLarge?.color),
                            ),
                            IconButton(
                              onPressed: () {
                                if (animationController.status !=
                                    AnimationStatus.completed) {
                                  animationController.forward();
                                } else {
                                  animationController.reverse();
                                }
                              },
                              splashRadius: 20,
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                          ],
                        ),
                        SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.vertical,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntrinsicHeight(
                                child: VerticalDivider(
                                  width: 5,
                                  thickness: 5,
                                  color: Colors.red,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "The following is a list of lessons you have attended\nYou can review the details of the lessons you have attended",
                                  style: context.textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildBody(scheduleState),
            ],
          ),
        ),
      ),
    );
  }
}