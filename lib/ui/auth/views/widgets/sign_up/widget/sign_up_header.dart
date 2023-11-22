import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/auth/views/page_controller.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              hoverColor: context.theme.hintColor,
              onTap: context.read<AuthPageController>().openSignIn,
              child: Icon(
                CupertinoIcons.back,
                color: context.theme.primaryColor,
              ),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
                children: [
                  TextSpan(text: context.l10n.welcomeTo),
                  TextSpan(
                    text: 'LeTutor'.toUpperCase(),
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.createAccount,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
