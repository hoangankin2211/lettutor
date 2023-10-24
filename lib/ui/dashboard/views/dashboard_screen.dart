import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/ui/course/views/course_screen.dart';
import 'package:lettutor/ui/dashboard/blocs/dashboard_state.dart';
import 'package:lettutor/ui/home/views/home_screen.dart';
import 'package:lettutor/ui/schedule/view/schedule_screen.dart';
import 'package:lettutor/ui/setting/views/setting_screen.dart';
import 'package:lettutor/ui/tutor/views/tutor_screen.dart';

import '../blocs/dashboard_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  late final controller = PageController(
    initialPage: currentIndex.value,
    keepPage: true,
  );

  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  final dashboardBloc = injector.get<DashboardBloc>();

  late final List<Map<String, dynamic>> _tabs = [
    {
      'title': 'Home',
      'icon': CupertinoIcons.house_alt_fill,
      "widget": HomeScreen(),
    },
    {
      'title': 'Teachers',
      'icon': CupertinoIcons.person_2_fill,
      "widget": BlocProvider(
        create: (context) => dashboardBloc.tutorBloc,
        child: const TutorScreen(),
      ),
    },
    {
      'title': 'Schedule',
      'icon': CupertinoIcons.calendar,
      "widget": BlocProvider(
        create: (context) => dashboardBloc.scheduleBloc,
        child: ScheduleScreen(),
      ),
    },
    {
      'title': 'Courses',
      'icon': CupertinoIcons.book_fill,
      "widget": MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => dashboardBloc.courseBloc,
          ),
          BlocProvider(
            create: (context) => dashboardBloc.courseBloc,
          ),
        ],
        child: CourseScreen(),
      ),
    },
    {
      'title': 'Setting',
      'icon': CupertinoIcons.settings_solid,
      "widget": SettingScreen(),
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardBloc.fetchInitialApplicationData();
  }

  void _onTap(int index) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentIndex.value = index;
    });
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => dashboardBloc,
      child: Builder(builder: (context) {
        return SafeArea(
          child: BlocConsumer<DashboardBloc, DashboardState>(
            bloc: dashboardBloc,
            listener: (context, state) {},
            builder: (context, dashboardState) {
              return Scaffold(
                backgroundColor: context.colorScheme.background,
                body: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: _tabs.map((e) => e["widget"] as Widget).toList(),
                ),
                bottomNavigationBar: ValueListenableBuilder<int>(
                  valueListenable: currentIndex,
                  builder: (context, value, _) => BottomNavigationBar(
                    onTap: _onTap,
                    backgroundColor: context.colorScheme.background,
                    currentIndex: value,
                    selectedIconTheme:
                        IconThemeData(color: context.theme.indicatorColor),
                    unselectedIconTheme:
                        IconThemeData(color: context.theme.disabledColor),
                    selectedLabelStyle: context.textTheme.bodyMedium,
                    unselectedLabelStyle: context.textTheme.bodyMedium
                        ?.copyWith(color: Colors.black),
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
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
