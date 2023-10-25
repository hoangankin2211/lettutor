import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/core/components/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/data/entities/feedback/feedback_entity.dart';
import 'package:lettutor/ui/home/views/widgets/home_item_component.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_detail_state.dart';
import 'package:lettutor/ui/tutor/views/widgets/specialties_component.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_video_player.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/components/widgets/ratting_widget_custom.dart';
import '../blocs/tutor_detail_bloc.dart';
import 'widgets/tutor_info_header.dart';

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({
    super.key,
    required this.tutorId,
  });

  final String tutorId;

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  late final TutorDetailBloc tutorDetailBloc;
  @override
  void initState() {
    initBloc();
    super.initState();
  }

  initBloc() {
    tutorDetailBloc = injector.get<TutorDetailBloc>();
    tutorDetailBloc.fetchTutorDetailData(widget.tutorId);
  }

  Widget _buildReviewItem(FeedbackEntity feedback) {
    return ListTile(
      isThreeLine: true,
      leading: feedback.feedBackUserModelEntity != null
          ? CircleAvatar(
              foregroundImage:
                  NetworkImage(feedback.feedBackUserModelEntity!.avatar ?? ""),
            )
          : null,
      title: Text(
        feedback.feedBackUserModelEntity!.name ?? "",
        style: context.textTheme.bodyLarge,
      ),
      subtitle: Text(feedback.content ?? ""),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (feedback.createdAt != null)
            Text(
              timeago.format(feedback.createdAt!),
              style: context.textTheme.bodyMedium,
            ),
          RattingWidgetCustom(rating: feedback.rating ?? 0),
        ],
      ),
    );
  }

  Widget buildListReview(List<FeedbackEntity> feedbacks, {int? max}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: feedbacks
            .take(max ?? feedbacks.length)
            .map<Widget>(
              (feedback) => (feedback.feedBackUserModelEntity != null)
                  ? _buildReviewItem(feedback)
                  : const SizedBox(),
            )
            .toList(),
      ),
    );
  }

  Widget buildListReviewComponent(List<FeedbackEntity> feedbacks) {
    return HomeItemComponent(
      isPadding: false,
      trailing: TextButton(
        onPressed: () {
          context.showAppModalBottomSheet(
              builder: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: buildListReview(feedbacks)));
        },
        child: Text(
          'Show More',
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.colorScheme.primary),
        ),
      ),
      verticalBodyGap: 0,
      title: "Others Review",
      body: buildListReview(feedbacks, max: 3),
    );
  }

  Widget buildListButton(VoidCallback openBooking) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: Colors.transparent),
          onPressed: openBooking,
          child: Column(
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: context.colorScheme.primary,
              ),
              Text(
                "Book this tutor",
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: context.colorScheme.primary),
              )
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: Colors.transparent),
          onPressed: () {},
          child: Column(
            children: [
              Icon(
                Icons.favorite_border,
                color: Colors.pink.shade600,
              ),
              Text(
                "Favorite",
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: Colors.pink.shade600),
              )
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: Colors.transparent),
          onPressed: () {},
          child: Column(
            children: [
              Icon(
                Icons.report,
                color: Colors.blue.shade600,
              ),
              Text(
                "Report",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.blue.shade600,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDescription(String description) {
    return ReadMoreText(
      description,
      trimLines: 4,
      colorClickableText: context.theme.primaryColor,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: context.textTheme.titleSmall,
      lessStyle: context.textTheme.titleSmall,
    );
  }

  @override
  void dispose() {
    tutorDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutorDetailBloc, TutorDetailState>(
      bloc: tutorDetailBloc,
      buildWhen: (previous, current) => current.isMainState,
      builder: (context, tutorDetailState) {
        final tutorDetail = tutorDetailState.data.tutorDetail;
        final feedbacks = tutorDetailState.data.feedbacks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tutor Detail'),
          ),
          body: tutorDetailState is TutorDetailLoading ||
                  tutorDetailState is TutorDetailInitial
              ? const Center(child: AppLoadingIndicator())
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        if (tutorDetail.video != null)
                          LetTutorVideoPlayer(
                            height: context.height * 0.3,
                            url: tutorDetail.video!,
                            width: context.width * 0.9,
                            autoPlay: false,
                          ),
                        if (tutorDetail.user != null)
                          TutorInfoHeader(
                            profession: tutorDetail.profession ?? "",
                            avatar: tutorDetail.user!.avatar ?? "",
                            country: tutorDetail.user!.country ?? "en",
                            name: tutorDetail.user!.name ?? "",
                            numOfFeedback: tutorDetail.totalFeedback ?? 0,
                          ),
                        buildListButton(() {
                          context.push(RouteLocation.booking,
                              extra: {"tutorDetailBloc": tutorDetailBloc});
                        }),
                        buildDescription(tutorDetail.bio ?? ""),
                        HomeItemComponent(
                          isPadding: false,
                          title: "Education ",
                          body: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              tutorDetail.education ?? "",
                              style: context.textTheme.titleMedium
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        HomeItemComponent(
                          isPadding: false,
                          title: "Languages",
                          body: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: (tutorDetail.languages ?? "")
                                  .split(RegExp(r'[,]'))
                                  .map(
                                      (e) => SpecialtiesComponent(specialty: e))
                                  .toList(),
                            ),
                          ),
                        ),
                        HomeItemComponent(
                          isPadding: false,
                          title: "Specialties",
                          body: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Wrap(
                              runSpacing: 5,
                              spacing: 5,
                              direction: Axis.horizontal,
                              children: (tutorDetail.specialties ?? "")
                                  .split(RegExp(r'[,]'))
                                  .map(
                                      (e) => SpecialtiesComponent(specialty: e))
                                  .toList(),
                            ),
                          ),
                        ),
                        if (tutorDetail.user != null)
                          HomeItemComponent(
                            verticalBodyGap: 0,
                            isPadding: false,
                            title: "Suggested Courses",
                            body: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (tutorDetail.user!.courses ?? [])
                                  .map(
                                    (e) => TextButton(
                                      onPressed: () {
                                        context.push(
                                          RouteLocation.courseDetail,
                                          extra: {"courseId": e.id},
                                        );
                                      },
                                      child: Text(
                                        e.name,
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: context.colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        HomeItemComponent(
                          isPadding: false,
                          title: "Interests",
                          body: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              tutorDetail.interests ?? "",
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                        ),
                        HomeItemComponent(
                          isPadding: false,
                          title: "Teaching Experience",
                          body: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              tutorDetail.experience ?? "",
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                        ),
                        buildListReviewComponent(feedbacks),
                      ]
                          .expand<Widget>((element) => [
                                element,
                                const SizedBox(height: 15),
                              ])
                          .toList(),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
