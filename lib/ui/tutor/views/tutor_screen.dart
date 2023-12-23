import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/constants/enum.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/navigation/routes_location.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/utils/widgets/custom_appbar.dart';
import 'package:lettutor/core/utils/widgets/custom_stack_scroll.dart';
import 'package:lettutor/core/utils/widgets/infinity_scroll_view.dart';
import 'package:lettutor/data/entities/request/tutor_search_request.dart';
import 'package:lettutor/domain/models/tutor/tutor.dart';
import 'package:lettutor/ui/course/views/widgets/course_search_bar.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_bloc.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_widget.dart';

import 'widgets/filter_sheet.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({super.key});

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();
  TutorBloc get tutorBloc => BlocProvider.of<TutorBloc>(context);

  @override
  bool get wantKeepAlive => true;

  Set<National> convertMapToSet(Map<String, dynamic>? nationalMap) {
    Set<National> result = {};

    if (nationalMap == null) return {};

    if (nationalMap.containsKey("isNative") &&
        nationalMap["isNative"] == true) {
      result.add(National.native);
    }

    if (nationalMap.containsKey("isVietnamese") &&
        nationalMap["isVietnamese"] == true) {
      result.add(National.vietnam);
    }

    if (nationalMap.containsKey("isVietnamese") &&
        nationalMap["isVietnamese"] == false &&
        nationalMap.containsKey("isNative") &&
        nationalMap["isNative"] == false) {
      result.add(National.foreign);
    }

    return result;
  }

  void showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.theme.dialogBackgroundColor,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (context) {
        var filter = tutorBloc.state.data.filter;
        return FilterSheet(
          endTime: filter != null && filter.tutoringTimeAvailable.isNotEmpty
              ? TimeOfDay.fromDateTime(
                  DateTime.fromMillisecondsSinceEpoch(
                    filter.tutoringTimeAvailable[1],
                  ),
                )
              : null,
          startTime: filter != null && filter.tutoringTimeAvailable.isNotEmpty
              ? TimeOfDay.fromDateTime(
                  DateTime.fromMillisecondsSinceEpoch(
                    filter.tutoringTimeAvailable[0],
                  ),
                )
              : null,
          national: filter != null ? convertMapToSet(filter.nationality) : null,
          selectedDate: filter?.date,
          selectedTag: filter != null && filter.specialties.isNotEmpty
              ? TutorTag.fromKey(filter.specialties.first)
              : null,
          onDone: (result) {
            tutorBloc.searchTutor(
              filter:
                  (tutorBloc.state.data.filter ?? const TutorSearchRequest())
                      .copyWith(
                          perPage: 12,
                          page: 1,
                          date: result['selectedDate'],
                          nationality: result['national'],
                          specialties: result['selectedTag'],
                          tutoringTimeAvailable: switch (result) {
                            (Map<String, dynamic> result)
                                when result["startTime"] != null &&
                                    result["endTime"] != null =>
                              <int>[
                                result["startTime"],
                                result["endTime"],
                              ],
                            _ => <int>[],
                          }),
            );
            context.pop();
          },
        );
      },
    );
  }

  Widget _buildHeader(TutorState tutorState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // GestureDetector(
        //   onTap: tutorBloc.fetchUpcomingClass,
        //   child: UpComingWidget(
        //     nextClass: tutorState.data.nextTutor,
        //     totalLearnTime: tutorState.data.totalLearnTime,
        //   ),
        // ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: context.theme.primaryColor),
              child: SvgPicture.asset(
                "assets/images/ic_lettutor_anytime_anywhere.svg",
                height: 50,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              context.l10n.findATutor,
              style: context.textTheme.headlineSmall?.boldTextTheme,
            ),
          ],
        ),
        const SizedBox(height: 2),
        CourseSearchBar(
          controller: searchController,
          onTapFilter: showFilterBottomSheet,
          onSearch: (value) => tutorBloc.searchTutor(
            filter: TutorSearchRequest(
              perPage: 10,
              page: 1,
              search: value,
            ),
          ),
        ),
      ]
          .expand<Widget>((element) => [
                element,
                const SizedBox(height: 5),
              ])
          .toList(),
    );
  }

  _buildBody(TutorState tutorState) {
    return Expanded(
      child: tutorState is TutorLoading
          ? const Center(child: AppLoadingIndicator())
          : RefreshIndicator(
              onRefresh: tutorBloc.loadTutor,
              child: tutorState.data.tutors.isEmpty
                  ? CustomTemplateScreenStackScroll(
                      appBar: AppBarCustom(
                        expandedHeight: context.height * 0.3,
                        backgroundColor: Colors.transparent,
                      ),
                      children: [
                        SliverToBoxAdapter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_search_outlined,
                                color: context.theme.hintColor.withOpacity(0.5),
                                size: 100,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "Sorry we can't find any tutor with this keywords",
                                    style: context
                                        .textTheme.headlineSmall?.boldTextTheme,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: DefaultPagination<Tutor>(
                        page: tutorState.data.page,
                        totalPage: tutorState.data.totalPage,
                        itemBuilder: (context, index) {
                          final tutor = tutorState.data.tutors[index];
                          return TutorWidget(
                            isFavorite: tutor.isFavoriteTutor,
                            markFavorite: (value) {
                              tutorBloc.markFavorite(tutor.userId, value);
                            },
                            onTap: () {
                              context.push(
                                RouteLocation.tutorDetail,
                                extra: {"tutorId": tutor.userId},
                              );
                            },
                            imageUrl: tutor.avatar,
                            name: tutor.name,
                            country: tutor.country,
                            specialties:
                                tutor.specialties.split(RegExp(r'[-\n ,]')),
                            rating: tutor.rating,
                            description: tutor.bio,
                            price: tutor.price,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        items: tutorState.data.tutors,
                        listenScrollBottom: () {
                          tutorBloc.loadMoreTutor(
                              page: tutorState.data.page + 1);
                        },
                      ),
                    ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TutorBloc, TutorState>(
      bloc: tutorBloc,
      builder: (context, tutorState) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildHeader(tutorState),
                _buildBody(tutorState),
              ],
            ),
          ),
        );
      },
    );
  }
}
