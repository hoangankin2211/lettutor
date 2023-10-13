import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/course/views/widgets/course_widget.dart';
import 'package:lettutor/ui/home/views/widgets/home_item_component.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_widget.dart';

import '../../../domain/usecases/tutor_usecase.dart';
import '../../auth/blocs/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final authBloc = BlocProvider.of<AuthBloc>(context);

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
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: context.height * 0.22),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => const SizedBox(width: 20),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => CourseWidget(
            courseId: index.toString() + "a",
            onTap: (id) {
              context.push("/${RouteLocation.courseDetail}",
                  extra: <String, dynamic>{"courseId": id});
            },
            imageUrl:
                "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e",
            title: "Life in the Internet Age",
            subTitle:
                "Let's discuss how technology is changing the way we live",
            level: "Intermediate",
          ),
          itemCount: 5,
        ),
      ),
    );
  }

  _buildRecommendCourse() {
    return HomeItemComponent(
      title: "Recommend Course",
      leading: Icon(Icons.schedule, color: context.theme.primaryColor),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: context.height * 0.22),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 20,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => CourseWidget(
            courseId: index.toString() + "a",
            onTap: (id) {
              context.pushNamed(RouteLocation.courseDetail,
                  extra: {"courseId": id});
            },
            imageUrl:
                "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e",
            title: "Life in the Internet Age",
            subTitle:
                "Let's discuss how technology is changing the way we live",
            level: "Intermediate",
          ),
          itemCount: 5,
        ),
      ),
    );
  }

  _buildRecommendTutor() {
    return HomeItemComponent(
      title: "Recommend Tutor",
      leading: Icon(Icons.schedule, color: context.theme.primaryColor),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: context.height * 0.38),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 20,
          ),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => TutorWidget(
            imageUrl:
                "https://api.app.lettutor.com/avatar/83802576-70fe-4394-b27a-3d9e8b50f1b7avatar1649512219387.jpg",
            name: "name",
            country: "country",
            specialties: List.generate(6, (index) => "sadfasd"),
            rating: 4.5,
            description:
                "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
            price: 80,
          ),
          itemCount: 5,
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
