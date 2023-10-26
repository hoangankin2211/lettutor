import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/course/views/widgets/course_widget.dart';
import 'package:lettutor/ui/dashboard/blocs/dashboard_bloc.dart';
import 'package:lettutor/ui/home/views/widgets/home_item_component.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_widget.dart';
import 'package:lettutor/ui/tutor/views/widgets/upcoming_lesson_widget.dart';

import '../../auth/blocs/auth_bloc.dart';
import '../../course/blocs/course_bloc.dart';
import '../../tutor/blocs/tutor_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final authBloc = BlocProvider.of<AuthBloc>(context);
  late final dashboardBloc = BlocProvider.of<DashboardBloc>(context);

  _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      height: context.height * 0.2,
      decoration: BoxDecoration(
        color: context.theme.primaryColor,
        borderRadius:
            const BorderRadius.only(bottomRight: Radius.circular(300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Hello, Hoang !",
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                    text: "Welcome to ",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "LetTutor",
                        style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimary),
                      ),
                    ]),
              ),
            ],
          ),
          Image.asset(
            "assets/images/home_v4.png",
            filterQuality: FilterQuality.high,
            cacheHeight: 200,
          )
        ],
      ),
    );
  }

  _buildUpComingCourse() {
    return HomeItemComponent(
      title: "Upcoming course",
      leading: Icon(Icons.schedule, color: context.theme.primaryColor),
      body: BlocBuilder<TutorBloc, TutorState>(
        bloc: dashboardBloc.tutorBloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: UpComingWidget(
              nextClass: state.data.nextTutor,
              totalLearnTime: state.data.totalLearnTime,
            ),
          );
        },
      ),
    );
  }

  _buildRecommendCourse() {
    return HomeItemComponent(
      title: "Recommend Course",
      leading: Icon(Icons.schedule, color: context.theme.primaryColor),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: context.height * 0.22),
        child: BlocBuilder<CourseBloc, CourseState>(
          bloc: dashboardBloc.courseBloc,
          builder: (context, state) {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final courseItem = state.data.course.elementAt(index);
                return CourseWidget(
                  key: ValueKey("${courseItem.id}_HomeScreen"),
                  courseId: courseItem.id,
                  onTap: (id) {
                    context.push(
                      RouteLocation.courseDetail,
                      extra: {
                        "courseId": id,
                        "from": "HomeScreen",
                      },
                    );
                  },
                  imageUrl: courseItem.imageUrl,
                  title: courseItem.name,
                  subTitle: courseItem.description,
                  level: courseItem.level,
                );
              },
              itemCount:
                  state.data.course.length < 5 ? state.data.course.length : 5,
            );
          },
        ),
      ),
    );
  }

  _buildRecommendTutor() {
    return HomeItemComponent(
      title: "Recommend Tutor",
      leading: Icon(Icons.schedule, color: context.theme.primaryColor),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: context.height * 0.39 + 5),
        child: BlocBuilder<TutorBloc, TutorState>(
          bloc: dashboardBloc.tutorBloc,
          builder: (context, state) {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final tutor = state.data.tutors[index];

                return TutorWidget(
                  onTap: () {
                    context.push(
                      RouteLocation.tutorDetail,
                      extra: {"tutorId": tutor.userId},
                    );
                  },
                  imageUrl: tutor.avatar,
                  name: tutor.name,
                  country: tutor.country,
                  specialties: tutor.specialties.split(RegExp(r'[-\n ,]')),
                  rating: tutor.rating,
                  description: tutor.bio,
                  price: tutor.price,
                );
              },
              itemCount:
                  state.data.tutors.length < 5 ? state.data.tutors.length : 5,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Image.asset(
          "assets/images/splash.png",
          cacheHeight: 50,
          cacheWidth: 50,
        ),
        backgroundColor: context.theme.cardColor,
        title: Text(
          "LetTutor",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.theme.primaryColor,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                authBloc.add(LogoutAuthenticationRequest());
              },
              child: const Text("Logout"))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Flexible(child: _buildUpComingCourse()),
            Flexible(child: _buildRecommendCourse()),
            Flexible(child: _buildRecommendTutor()),
          ],
        ),
      ),
    );
  }
}
