import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/ui/chat/bloc/chat_cubit.dart';
import 'package:lettutor/ui/chat/bloc/chat_list_cubit.dart';
import 'package:lettutor/ui/chat/chat_list.dart';
import 'package:lettutor/ui/chat/chat_screen.dart';
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
      'title': context.l10n.Home,
      'icon': CupertinoIcons.house_alt_fill,
      "widget": const HomeScreen(),
    },
    {
      'title': "Messages",
      'icon': CupertinoIcons.chat_bubble_2,
      "widget": MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => injector.get<ChatListCubit>()),
          BlocProvider(create: (context) => injector.get<ChatCubit>()),
        ],
        child: const ChatListScreen(),
      ),
    },
    {
      'title': context.l10n.Teachers,
      'icon': CupertinoIcons.person_2_fill,
      "widget": BlocProvider(
        create: (context) => dashboardBloc.tutorBloc,
        child: const TutorScreen(),
      ),
    },
    {
      'title': context.l10n.schedule,
      'icon': CupertinoIcons.calendar,
      "widget": BlocProvider(
        create: (context) => dashboardBloc.scheduleBloc,
        child: const ScheduleScreen(),
      ),
    },
    {
      'title': context.l10n.courses,
      'icon': CupertinoIcons.book_fill,
      "widget": MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => dashboardBloc.courseBloc,
          ),
          BlocProvider(
            create: (context) => dashboardBloc.eBookBloc,
          ),
        ],
        child: const CourseScreen(),
      ),
    },
    {
      'title': context.l10n.setting,
      'icon': CupertinoIcons.settings_solid,
      "widget": const SettingScreen(),
    },
  ];

  @override
  void initState() {
    super.initState();
    dashboardBloc.fetchInitialApplicationData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTap(int index) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if ((index - currentIndex.value).abs() > 1) {
        controller.jumpToPage(index);
      } else {
        controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      currentIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => dashboardBloc,
      child: Builder(builder: (context) {
        return SafeArea(
          child: BlocConsumer<DashboardBloc, DashboardState>(
            bloc: dashboardBloc,
            listener: (context, state) {
              if (state is DashboardTabChanged) {
                _onTap(state.data.currentPage);
              }
            },
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
