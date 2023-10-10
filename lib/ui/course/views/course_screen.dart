import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/ui/course/views/widgets/course_widget.dart';

import '../blocs/course_bloc.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final courseBloc = BlocProvider.of<CourseBloc>(context);

  @override
  void initState() {
    courseBloc.fetchCourseList(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor),
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is LoadingListCourse) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                final course = state.data.course.elementAt(index);
                return CourseWidget(
                  imageUrl: course.imageUrl,
                  title: course.name,
                  subTitle: course.description,
                  level: course.level,
                );
              },
            );
          }
        },
      ),
    );
  }
}
