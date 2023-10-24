import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/core/components/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/components/widgets/infinity_scroll_view.dart';
import 'package:lettutor/data/entities/request/tutor_search_request.dart';
import 'package:lettutor/domain/models/tutor/tutor.dart';
import 'package:lettutor/ui/course/views/course_screen.dart';
import 'package:lettutor/ui/course/views/widgets/course_search_bar.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_bloc.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_widget.dart';
import 'package:lettutor/ui/tutor/views/widgets/upcoming_lesson_widget.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({super.key});

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen>
    with AutomaticKeepAliveClientMixin {
  late final tutorBloc = BlocProvider.of<TutorBloc>(context);
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // tutorBloc.loadTutor();
    // tutorBloc.fetchUpcomingClass();
    super.initState();
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
        return const FilterSheet();
      },
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
                GestureDetector(
                  onTap: () {
                    tutorBloc.fetchUpcomingClass();
                  },
                  child: UpComingWidget(
                    nextClass: tutorState.data.nextTutor,
                    totalLearnTime: tutorState.data.totalLearnTime,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    tutorBloc.loadTutor();
                  },
                  child: Text(
                    'Find A Tutor',
                    style: context.textTheme.headlineSmall?.boldTextTheme,
                  ),
                ),
                const SizedBox(height: 10),
                CourseSearchBar(
                  controller: searchController,
                  onTapFilter: showFilterBottomSheet,
                  onSearch: (value) => tutorBloc.searchTutor(
                    TutorSearchRequest(
                      perPage: 10,
                      page: 1,
                      search: value,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: tutorState is TutorLoading
                      ? const Center(child: AppLoadingIndicator())
                      : RefreshIndicator(
                          onRefresh: tutorBloc.loadTutor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: DefaultPagination<Tutor>(
                              page: tutorState.data.page,
                              totalPage: tutorState.data.totalPage,
                              itemBuilder: (context, index) {
                                final tutor = tutorState.data.tutors[index];
                                return StreamBuilder<bool>(
                                  initialData: tutor.isFavoriteTutor,
                                  stream: tutor.favoriteController.stream,
                                  builder: (context, snapshot) => TutorWidget(
                                    isFavorite: snapshot.data ?? false,
                                    markFavorite: (value) {
                                      tutorBloc.markFavorite(
                                          tutor.userId, value);
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
                                    specialties: tutor.specialties
                                        .split(RegExp(r'[-\n ,]')),
                                    rating: tutor.rating,
                                    description: tutor.bio,
                                    price: tutor.price,
                                  ),
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
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
