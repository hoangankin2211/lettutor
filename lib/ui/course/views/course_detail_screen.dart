import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/domain/models/course/course.dart';
import 'package:lettutor/ui/course/blocs/course_detail_bloc.dart';
import 'package:lettutor/ui/home/views/widgets/home_item_component.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_stack_scroll.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late final CourseDetailBloc courseDetailBloc;

  final ValueNotifier<Color?> color = ValueNotifier(null);

  @override
  void initState() {
    initBloc();
    super.initState();
  }

  initBloc() {
    courseDetailBloc = injector.get<CourseDetailBloc>();
    courseDetailBloc.fetchCourseDetailData(widget.courseId);
  }

  _buildOverviewComponent(String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.question_circle,
              color: Colors.red,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: context.textTheme.bodyLarge,
        ),
      ],
    );
  }

  _buildOverviewSection({
    required String reason,
    required String purpose,
  }) {
    Map<String, dynamic> data = {
      "What take this course ?": reason,
      "What will you able to do ?": purpose,
    };
    return HomeItemComponent(
      title: "OverView",
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.entries
            .map((entries) =>
                _buildOverviewComponent(entries.key, entries.value))
            .expand<Widget>((element) => [
                  element,
                  const SizedBox(
                    height: 10,
                  )
                ])
            .toList(),
      ),
    );
  }

  _buildExperienceLevel() {
    return HomeItemComponent(
      title: "Experience Level",
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(CupertinoIcons.person_2_square_stack_fill),
          const SizedBox(width: 5),
          Text(
            "Intermediate",
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  _buildCourseLength(int length) {
    return HomeItemComponent(
      title: "Course Length",
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(CupertinoIcons.book),
          const SizedBox(width: 5),
          Text(
            "$length Topics",
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildTopicComponent({
    required String? pdfUrl,
    required String unit,
    required String description,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: context.theme.primaryColor.withOpacity(0.12),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ListTile(
        onTap: () {
          context.push(
              "${RouteLocation.courseDetail}/${RouteLocation.topicDetail}",
              extra: {"pdfUrl": pdfUrl});
        },
        titleTextStyle: context.textTheme.titleMedium?.boldTextTheme,
        title: Text("Unit $unit"),
        subtitleTextStyle: context.textTheme.titleSmall?.boldTextTheme,
        subtitle: Text(description),
        trailing: Text(
          "Learn Now",
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.theme.primaryColor),
        ),
      ),
    );
  }

  _buildListTopic(List<CourseTopic> topics) {
    return HomeItemComponent(
      title: "List Topics",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
                topics.length,
                (index) => _buildTopicComponent(
                      pdfUrl: topics.elementAt(index).nameFile,
                      description: topics.elementAt(index).name,
                      unit:
                          topics.elementAt(index).orderCourse?.toString() ?? "",
                    ))
            .expand<Widget>((element) => [element, const SizedBox(height: 8)])
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailBloc, CourseDetailState>(
        bloc: courseDetailBloc,
        // listenWhen: (previous, current) =>
        //     previous.runtimeType != current.runtimeType,
        listener: (context, state) async {
          if (state is LoadCourseDetailSuccess &&
              state.course?.imageUrl != null &&
              color.value == null) {
            final ImageProvider imageProvider = CachedNetworkImageProvider(
              state.course!.imageUrl!,
              cacheKey: state.course!.imageUrl!,
            );

            PaletteGenerator paletteGenerator =
                await PaletteGenerator.fromImageProvider(imageProvider);

            color.value = paletteGenerator.dominantColor?.color;
            courseDetailBloc.rebuildBloc();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar<Color?>(
              appBarBuilder: (context, color, child) {
                return AppBar(
                  elevation: 0,
                  backgroundColor: color,
                  leading: IconButton(
                    splashRadius: 20,
                    onPressed: () => context.pop(),
                    icon: const Icon(CupertinoIcons.back),
                  ),
                  title: Text(
                    state.course?.name ?? "",
                    style: context.myTitleLarge(
                        color: context.colorScheme.onPrimary),
                  ),
                );
              },
              value: color,
            ),
            body: (state is InitialCourseDetailPage ||
                    state is LoadingCourseDetail ||
                    color.value == null)
                ? const AppLoadingIndicator()
                : Stack(
                    children: [
                      CustomTemplateScreenStackScroll(
                        color: Colors.transparent,
                        paddingAll: const EdgeInsets.all(5),
                        afterMainScreen: Hero(
                          tag: widget.key ?? UniqueKey(),
                          child: FadeInImage.assetNetwork(
                            image: state.course?.imageUrl ?? "",
                            placeholder: "assets/images/placeholder.png",
                            fit: BoxFit.cover,
                            height: (context.height * 0.45 + 5),
                          ),
                        ),
                        bottomSheet: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.1, vertical: 10),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(context.width * 0.9, 50),
                              maximumSize: Size(context.width * 0.9, 60),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                                CupertinoIcons.arrowtriangle_right_circle_fill),
                            label: Text(
                              "Discover",
                              style: context.textTheme.titleLarge?.copyWith(
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        appBar: AppBarCustom(
                          expandedHeight: context.height * 0.4,
                          backgroundColor: Colors.transparent,
                          title: const [],
                        ),
                        children: [
                          SliverToBoxAdapter(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                color: context.colorScheme.onPrimary,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(25)),
                              ),
                              child: Column(
                                children: [
                                  _buildOverviewSection(
                                    purpose: state.course?.purpose ?? "",
                                    reason: state.course?.reason ?? "",
                                  ),
                                  _buildExperienceLevel(),
                                  _buildCourseLength(
                                      state.course?.topics?.length ?? 0),
                                  _buildListTopic(state.course?.topics ?? []),
                                  const SizedBox(height: 40),
                                ]
                                    .expand<Widget>((element) => [
                                          element,
                                          const SizedBox(height: 10),
                                        ])
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          );
        });
  }
}

class CustomAppBar<T> extends AppBar implements ValueListenableBuilder {
  final ValueNotifier<T> value;
  final Widget? appBarChild;
  final ValueWidgetBuilder appBarBuilder;

  CustomAppBar({
    super.key,
    this.appBarChild,
    required this.appBarBuilder,
    required this.value,
  });

  @override
  ValueWidgetBuilder get builder => appBarBuilder;

  @override
  Widget? get child => appBarChild;

  @override
  ValueListenable get valueListenable => value;

  @override
  State<AppBar> createState() => _CustomAppBarState<T>();
}

class _CustomAppBarState<T> extends State<CustomAppBar<T>> {
  late T? value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(covariant CustomAppBar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    setState(() {
      value = widget.valueListenable.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}
