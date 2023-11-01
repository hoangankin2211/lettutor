import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/navigation/routes_location.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          text ?? "l10n.somethingWentWrong",
          style: textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(RouteLocation.auth),
          child: Text(
            "l10n.goToHome",
            style: textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
