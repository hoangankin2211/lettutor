import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/course/blocs/course_detail_bloc.dart';
import 'package:lettutor/ui/home/views/widgets/home_item_component.dart';

import '../../../core/components/widgets/custom_appbar.dart';
import '../../../core/components/widgets/custom_stack_scroll.dart';
import 'widgets/course_widget.dart';

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
  // late final courseDetailBloc = BlocProvider.o f<CourseDetailBloc>(context);
  @override
  void initState() {
    // courseDetailBloc.fetchCourseDetailData("");
    super.initState();
  }

  _buildOverviewComponent() {
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
              "What will you able to do ?",
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          "asdfasdfasdfasdfasdfasasdfasdfasdfasdfasdfasasdfasdfasdfasdfasdfasasdfasdfasdfasdfasdfasasdfasdfasdfasdfasdfasasdfasdfasdfasdfasdfasasdfasdfasdfasdfasdfasasdfasdfasdfasdfasdfasasdfasdfasdfasdfasdfasasdfasdfasdfasdfasdfas",
          style: context.textTheme.bodyLarge,
        ),
      ],
    );
  }

  _buildOverviewSection() {
    return HomeItemComponent(
      title: "OverView",
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(2, (index) => _buildOverviewComponent())
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

  _buildCourseLength() {
    return HomeItemComponent(
      title: "Course Length",
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(CupertinoIcons.book),
          const SizedBox(width: 5),
          Text(
            "9 Topics",
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildTopicComponent() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: context.theme.primaryColor.withOpacity(
        0.12,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ListTile(
        onTap: () {},
        titleTextStyle: context.textTheme.titleMedium?.boldTextTheme,
        title: Text("Unit 1"),
        subtitleTextStyle: context.textTheme.titleSmall?.boldTextTheme,
        subtitle: Text("Introduction"),
        trailing: Text(
          "Learn Now",
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.theme.primaryColor),
        ),
      ),
    );
  }

  _buildListTopic() {
    return HomeItemComponent(
      title: "List Topics",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(6, (index) => _buildTopicComponent())
            .expand<Widget>((element) => [element, const SizedBox(height: 8)])
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => context.pop(),
          icon: const Icon(CupertinoIcons.back),
        ),
        title: Text(
          'Life in the internet age',
          style: context.myTitleLarge(color: context.colorScheme.onPrimary),
        ),
      ),
      body: Stack(
        children: [
          CustomTemplateScreenStackScroll(
            color: Colors.transparent,
            paddingAll: const EdgeInsets.all(5),
            afterMainScreen: Hero(
              tag: widget.courseId,
              child: Image.network(
                "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e",
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
                icon:
                    const Icon(CupertinoIcons.arrowtriangle_right_circle_fill),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      _buildOverviewSection(),
                      _buildExperienceLevel(),
                      _buildCourseLength(),
                      _buildListTopic(),
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
  }
}
