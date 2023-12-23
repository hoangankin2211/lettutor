import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/widgets/custom_appbar.dart';
import 'package:lettutor/core/utils/widgets/custom_stack_scroll.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';
import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';
import 'package:lettutor/ui/history/views/widgets/history_widget.dart';
import 'package:lettutor/ui/schedule/bloc/schedule_bloc.dart';

import '../../../core/utils/widgets/infinity_scroll_view.dart';

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
                child: scheduleState.data.schedules.isEmpty
                    ? CustomTemplateScreenStackScroll(
                        appBar: const AppBarCustom(
                          height: 0,
                          backgroundColor: Colors.transparent,
                        ),
                        children: [
                          SliverToBoxAdapter(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color:
                                      context.theme.hintColor.withOpacity(0.5),
                                  size: 100,
                                ),
                                Center(
                                  child: Text(
                                    "You have not enroll in any course yet",
                                    style: context.textTheme.headlineMedium
                                        ?.boldTextTheme,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : DefaultPagination<BookingInfoEntity>(
                        listenScrollBottom: scheduleBloc.loadMoreSchedule,
                        page: scheduleState.data.page,
                        totalPage: scheduleState.data.totalPage,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        items: scheduleState.data.schedules,
                        itemBuilder: (context, index) {
                          final bookingItem =
                              scheduleState.data.schedules[index];
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
                                (bookingItem.feedbacks?.map((e) => e.rating) ??
                                        [])
                                    .toList(),
                            time: bookingItem.createdAt ?? DateTime.now(),
                            studentRequest: bookingItem.studentRequest ?? "",
                            tutorName: bookingItem.scheduleDetailInfo
                                    ?.scheduleInfo?.tutorInfo.name ??
                                "",
                            avatar: bookingItem.scheduleDetailInfo?.scheduleInfo
                                    ?.tutorInfo.avatar ??
                                "",
                            country: bookingItem.scheduleDetailInfo
                                    ?.scheduleInfo?.tutorInfo.country ??
                                "",
                            startTime: DateFormat().add_Hm().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      bookingItem.scheduleDetailInfo!
                                          .startPeriodTimestamp),
                                ),
                            endTime: DateFormat().add_Hm().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      bookingItem.scheduleDetailInfo!
                                          .endPeriodTimestamp),
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
      builder: (context, scheduleState) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: context.pop,
                      constraints: const BoxConstraints(),
                      splashRadius: 20,
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
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
                                context.l10n.history,
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
                                constraints: const BoxConstraints(),
                                splashRadius: 20,
                                icon: const Icon(Icons.arrow_drop_down),
                              ),
                            ],
                          ),
                          SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.vertical,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const IntrinsicHeight(
                                  child: VerticalDivider(
                                    width: 5,
                                    thickness: 5,
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    context.l10n.historyScreen,
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
      ),
    );
  }
}
