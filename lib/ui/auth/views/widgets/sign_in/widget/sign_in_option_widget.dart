import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/ui/auth/views/page_controller.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_up/signup_screen.dart';

class SignInOptionWidget extends StatelessWidget {
  const SignInOptionWidget({
    super.key,
  });
  Widget buildSignInOptionButton(
    BuildContext context,
    String iconPath,
    String text,
  ) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0XFFE9F1FF),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 26,
            width: 26,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSignInOptionButton(
            context,
            "assets/images/ic_google.svg",
            context.l10n.signInGoogle,
          ),
          const SizedBox(
            height: 16,
          ),
          if (Platform.isIOS)
            buildSignInOptionButton(
              context,
              "assets/images/ic_apple.svg",
              context.l10n.signInApple,
            ),
          SizedBox(
            height: Platform.isIOS ? 16 : 0,
          ),
          buildSignInOptionButton(
            context,
            "assets/images/ic_facebook.svg",
            context.l10n.signInFace,
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: context.read<AuthPageController>().openSignUp,
            child: RichText(
              text: TextSpan(
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: context.theme.hintColor,
                ),
                children: [
                  TextSpan(text: context.l10n.noAccount),
                  TextSpan(
                    text: context.l10n.signUp,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
