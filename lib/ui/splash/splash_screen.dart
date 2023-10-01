import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.pink.shade100,
              Colors.blueAccent.shade100,
              Colors.blueAccent.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              'assets/images/splash.png',
              scale: 1,
              cacheWidth: 250,
            ),
            Text(
              "LetTutor",
              style: context.textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
