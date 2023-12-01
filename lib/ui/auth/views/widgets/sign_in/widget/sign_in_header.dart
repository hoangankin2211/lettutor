import 'package:flutter/material.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/images/splash.png", height: 70),
        RichText(
          text: TextSpan(
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(text: context.l10n.welcomeTo),
              TextSpan(
                text: 'LetTutor'.toUpperCase(),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
