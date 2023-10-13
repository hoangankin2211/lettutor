import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/domain/models/course/course.dart';
import 'package:lettutor/ui/course/blocs/ebook_bloc.dart';
import 'package:lettutor/ui/course/blocs/ebook_state.dart';
import 'package:lettutor/ui/course/views/widgets/course_search_bar.dart';
import 'package:lettutor/ui/course/views/widgets/course_widget.dart';

import '../../../core/components/widgets/custom_navigator_bar.dart';
import '../../../core/core.dart';
import '../blocs/course_bloc.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomNavigatorBar(
              tabs: [
                "Course",
                "E-Book",
                "Interactive",
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CourseSearchBar(controller: TextEditingController()),
          ),
          Expanded(
            child: PageView(
              children: const [ListCoursePage(), ListEBookPage()],
            ),
          ),
        ]
            .expand<Widget>((element) => [
                  element,
                  const SizedBox(height: 20),
                ])
            .toList(),
      ),
    );
  }
}

class ListCoursePage extends StatefulWidget {
  const ListCoursePage({super.key});

  @override
  State<ListCoursePage> createState() => _ListCoursePageState();
}

class _ListCoursePageState extends State<ListCoursePage> {
  late final courseBloc = BlocProvider.of<CourseBloc>(context);

  @override
  void didChangeDependencies() {
    courseBloc.fetchCourseList(page: 1);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        if (state is LoadingListCourse || state is LoadingListCourse) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            shrinkWrap: true,
            itemCount: 10,
            addAutomaticKeepAlives: true,
            itemBuilder: (context, index) {
              final courseItem = state.data.course.elementAt(index);
              return CourseWidget(
                onTap: (id) {
                  context.push(
                    RouteLocation.courseDetail,
                    extra: {"courseId": id},
                  );
                },
                courseId: courseItem.id,
                imageUrl: courseItem.imageUrl,
                title: courseItem.name,
                subTitle: courseItem.description,
                level: courseItem.level,
              );
            },
          );
        }
      },
    );
  }
}

class ListEBookPage extends StatefulWidget {
  const ListEBookPage({super.key});

  @override
  State<ListEBookPage> createState() => _ListEBookPageState();
}

class _ListEBookPageState extends State<ListEBookPage> {
  late final eBookBloc = BlocProvider.of<EBookBloc>(context);

  @override
  void didChangeDependencies() {
    eBookBloc.fetchEBookList(page: 1, perPage: 12);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EBookBloc, EBookState>(
      builder: (context, state) {
        if (state is LoadingListEBook || state is InitialEBookListPage) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LoadListEBookSuccess) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            shrinkWrap: true,
            itemCount: 10,
            addAutomaticKeepAlives: true,
            itemBuilder: (context, index) {
              final ebookItem = state.data.eBook.elementAt(index);
              return CourseWidget(
                courseId: ebookItem.id,
                imageUrl: ebookItem.imageUrl,
                title: ebookItem.name,
                subTitle: ebookItem.description,
                level: ebookItem.level,
              );
            },
          );
        } else {
          return const Center(child: Text("Error"));
        }
      },
    );
  }
}
