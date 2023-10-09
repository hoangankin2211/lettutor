import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = CupertinoTabController(initialIndex: 0);

  final List<Map<String, dynamic>> _tabs = [
    {
      'title': 'Favorites',
      'icon': CupertinoIcons.star_fill,
    },
    {
      'title': 'Recents',
      'icon': CupertinoIcons.clock_solid,
    },
    {
      'title': 'Contacts',
      'icon': CupertinoIcons.person_alt_circle_fill,
    },
    {
      'title': 'Keypad',
      'icon': CupertinoIcons.circle_grid_3x3_fill,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: context.colorScheme.background,
      controller: controller,
      tabBar: CupertinoTabBar(
        items: _tabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab['icon']),
                label: tab['title'],
              ),
            )
            .toList(),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return Center(
              child: Text('Content of tab $index'),
            );
          },
        );
      },
    );
  }
}
