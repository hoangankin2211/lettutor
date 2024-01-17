import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/views/page_controller.dart';

class SignInOptionWidget extends StatefulWidget {
  final String? otherChoice;
  final VoidCallback? onTapOtherChoice;
  const SignInOptionWidget(
      {super.key, this.otherChoice, this.onTapOtherChoice});

  @override
  State<SignInOptionWidget> createState() => _SignInOptionWidgetState();
}

class _SignInOptionWidgetState extends State<SignInOptionWidget> {
  AuthenticationBloc get authBloc =>
      BlocProvider.of<AuthenticationBloc>(context);

  Widget buildSignInOptionButton(
    BuildContext context,
    String iconPath,
    String text, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            onTap: () {
              authBloc.add(GoogleSignInRequest());
            },
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
            onTap: () => authBloc.add(FacebookSignInRequest()),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: widget.onTapOtherChoice ??
                context.read<AuthPageController>().openSignUp,
            child: RichText(
              text: TextSpan(
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: context.theme.hintColor,
                ),
                children: [
                  TextSpan(text: widget.otherChoice ?? context.l10n.noAccount),
                  TextSpan(
                    text: widget.otherChoice == null
                        ? context.l10n.signUp
                        : context.l10n.signIn,
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
