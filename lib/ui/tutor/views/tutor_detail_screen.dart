import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/data/entities/feedback/feedback_entity.dart';
import 'package:lettutor/ui/home/views/widgets/home_item_component.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_detail_state.dart';
import 'package:lettutor/ui/tutor/views/widgets/specialties_component.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_video_player.dart';
import 'package:country_picker/country_picker.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/components/widgets/pagination_widget.dart';
import '../../../core/components/widgets/ratting_widget_custom.dart';
import '../blocs/tutor_detail_bloc.dart';

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

  Widget buildListReviewComponent(List<FeedbackEntity> feedbacks) {
    return HomeItemComponent(
      title: "Others Review",
      body: Column(
        children: feedbacks
            .map<Widget>(
              (feedback) => (feedback.feedBackUserModelEntity != null)
                  ? ListTile(
                      isThreeLine: true,
                      minVerticalPadding: 0,
                      contentPadding: EdgeInsets.zero,
                      leading: feedback.feedBackUserModelEntity != null
                          ? CircleAvatar(
                              foregroundImage: NetworkImage(
                                  feedback.feedBackUserModelEntity!.avatar ??
                                      ""),
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
                    )
                  : const SizedBox(),
            )
            .toList()
          ..add(
            PaginationWidget(
              page: 1,
              totalPage: 20,
              onBack: () {},
              onNext: () {},
            ),
          ),
      ),
    );
  }

  Widget get buildListButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        SizedBox(width: context.width * 0.25),
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
  Widget build(BuildContext context) {
    return BlocBuilder<TutorDetailBloc, TutorDetailState>(
      bloc: tutorDetailBloc,
      builder: (context, tutorDetailState) {
        final tutorDetail = tutorDetailState.data.tutorDetail;
        final feedbacks = tutorDetailState.data.feedbacks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tutor Detail'),
          ),
          body: SingleChildScrollView(
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
                  buildListButton,
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
                            .map((e) => SpecialtiesComponent(specialty: e))
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
                            .map((e) => SpecialtiesComponent(specialty: e))
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
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
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

class TutorInfoHeader extends StatefulWidget {
  const TutorInfoHeader({
    super.key,
    required this.avatar,
    required this.name,
    required this.numOfFeedback,
    required this.country,
    required this.profession,
  });

  final String avatar;
  final String name;
  final String profession;
  final int numOfFeedback;
  final String country;

  @override
  State<TutorInfoHeader> createState() => _TutorInfoHeaderState();
}

class _TutorInfoHeaderState extends State<TutorInfoHeader> {
  late String _avatar = widget.avatar;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          foregroundImage: NetworkImage(_avatar),
          onForegroundImageError: (exception, stackTrace) {
            setState(() {
              _avatar =
                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
            });
          },
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: context.textTheme.titleLarge?.boldTextTheme,
            ),
            Text(
              widget.profession,
              style: context.textTheme.bodyLarge,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CountryFlag.fromCountryCode(
                  widget.country.toUpperCase(),
                  height: 25,
                  width: 45,
                  borderRadius: 8,
                ),
                Text(
                  Country.tryParse(widget.country)?.name ?? "Unknown",
                  style: context.textTheme.bodyLarge,
                )
              ],
            ),
          ]
              .expand<Widget>((element) => [element, const SizedBox(height: 5)])
              .toList(),
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => const Icon(
              Icons.star,
              color: Colors.orangeAccent,
              size: 16,
            ),
          )
              .expand<Widget>((element) => [element, const SizedBox(width: 4)])
              .toList()
            ..add(Text(
              "(${widget.numOfFeedback})",
              style: context.textTheme.titleMedium,
            )),
        ),
      ],
    );
  }
}
