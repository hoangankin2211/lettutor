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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: Text(
          'Courses',
          style: context.textTheme.titleLarge?.boldTextTheme,
        ),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is LoadingListCourse) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: CustomNavigatorBar()),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    shrinkWrap: true,
                    itemCount: 10,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (context, index) {
                      final course = state.data.course.elementAt(index);
                      return CourseWidget(
                        courseId: course.id,
                        imageUrl: course.imageUrl,
                        title: course.name,
                        subTitle: course.description,
                        level: course.level,
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class CustomNavigatorBar extends StatefulWidget {
  const CustomNavigatorBar({super.key});

  @override
  State<CustomNavigatorBar> createState() => _CustomNavigatorBarState();
}

class _CustomNavigatorBarState extends State<CustomNavigatorBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    super.initState();
  }

  final mapCoordinate = {
    0: 40,
    1: 170,
    2: 300,
  };

  int currentIndex = 0;

  void animateTo(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)
        ],
        borderRadius: BorderRadius.circular(20),
        color: context.theme.cardColor,
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Transform.translate(
              offset: Offset(
                  mapCoordinate[currentIndex]! +
                      animation.value * (mapCoordinate[currentIndex]! - 130),
                  40),
              child: child,
            ),
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.theme.primaryColor,
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "asdfsadf",
                  style: context.textTheme.titleMedium?.boldTextTheme,
                ),
                GestureDetector(
                  onTap: () {
                    animationController.forward(from: 0);
                  },
                  child: Text(
                    "asdfsadf",
                    style: context.textTheme.titleMedium?.boldTextTheme,
                  ),
                ),
                Text(
                  "asdfsadf",
                  style: context.textTheme.titleMedium?.boldTextTheme,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 