import 'package:flutter/material.dart';
import 'package:lettutor/core/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          "assets/images/logo.png",
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
          InkWell(),
        ],
      ),
    );
  }
}
