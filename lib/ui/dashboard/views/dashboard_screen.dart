import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/ui/course/blocs/course_bloc.dart';
import 'package:lettutor/ui/course/blocs/ebook_bloc.dart';
import 'package:lettutor/ui/course/views/course_detail_screen.dart';
import 'package:lettutor/ui/course/views/course_screen.dart';
import 'package:lettutor/ui/home/views/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PageController(initialPage: 0, keepPage: true);

  final List<Map<String, dynamic>> _tabs = [
    {
      'title': 'Home',
      'icon': CupertinoIcons.house_alt_fill,
      "widget": HomeScreen(),
    },
    {
      'title': 'Teachers',
      'icon': CupertinoIcons.person_2_fill,
      "widget": CourseDetailScreen(courseId: 0.toString()),
    },
    {
      'title': 'Schedule',
      'icon': CupertinoIcons.calendar,
      "widget": Placeholder(),
    },
    {
      'title': 'Courses',
      'icon': CupertinoIcons.book_fill,
      "widget": MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => injector.get<CourseBloc>(),
          ),
          BlocProvider(
            create: (context) => injector.get<EBookBloc>(),
          ),
        ],
        child: CourseScreen(),
      ),
    },
    {
      'title': 'Setting',
      'icon': CupertinoIcons.settings_solid,
      "widget": Placeholder(),
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      // appBar: AppBar(
      //   leading: Image.asset(
      //     "assets/images/splash.png",
      //     cacheHeight: 50,
      //     cacheWidth: 50,
      //   ),
      //   backgroundColor: context.theme.cardColor,
      //   title: Text(
      //     "LetTutor",
      //     style: context.textTheme.titleLarge?.copyWith(
      //       fontWeight: FontWeight.bold,
      //       color: context.theme.primaryColor,
      //     ),
      //   ),
      //   actions: [
      //     TextButton(
      //         onPressed: () {
      //           context.go(RouteLocation.auth);
      //         },
      //         child: const Text("Logout"))
      //   ],
      // ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: _tabs.map((e) => e["widget"] as Widget).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          controller.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceInOut);
        },
        backgroundColor: context.colorScheme.background,
        currentIndex: 0,
        selectedIconTheme: IconThemeData(color: context.theme.indicatorColor),
        unselectedIconTheme: IconThemeData(color: context.theme.disabledColor),
        selectedLabelStyle: context.textTheme.bodyMedium,
        unselectedLabelStyle:
            context.textTheme.bodyMedium?.copyWith(color: Colors.black),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: _tabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab['icon']),
                label: tab['title'],
              ),
            )
            .toList(),
      ),
    );
  }
}
