import 'package:flutter/material.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/chat/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawer: Drawer(
        width: context.width * 0.1,
        child: Column(
          children: List.generate(15, (index) => "Thread 1")
              .asMap()
              .entries
              .expand<Widget>((element) => [
                    Text("${element.value} ${element.key}"),
                    const SizedBox(height: 10)
                  ])
              .toList(),
        ),
      ),
      appBar: AppBar(title: const Text("OpenAI application")),
      body: ChatScreen(),
    );
  }
}
