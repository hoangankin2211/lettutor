import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/views/auth_screen.dart';
import 'package:lettutor/ui/auth/views/signin_screen.dart';

import 'widgets/custom_scaffold_appbar.dart';
import 'widgets/custom_scaffold_body.dart';
import 'widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const int pageNum = 1;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();

  Widget buildBackgroundView() {
    return Container(
      width: double.infinity,
      color: context.colorScheme.background,
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              hoverColor: context.theme.hintColor,
              onTap: () {
                BlocProvider.of<PageNotifier>(context)
                    .nextPage(SignInScreen.pageNum);
              },
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
                  TextSpan(text: 'Welcome to '),
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
              'Create Account',
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

  Widget buildSignUpForm() {
    var fillColor = context.colorScheme.onBackground;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'Email address',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TCInputField(
            height: 45,
            fillColor: fillColor,
            autocorrect: false,
            controller: _emailController,
            enableSuggestions: false,
            hintText: 'Email address',
            focusNode: _focusEmail,
            borderRadius: 5,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            ignoreShadow: true,
            onChanged: (value) => {},
            onFieldSubmitted: (text) {},
          ),
          const SizedBox(height: 16),
          Text(
            'Your password',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TCInputField(
            height: 45,
            fillColor: fillColor,
            autocorrect: false,
            controller: _passwordController,
            enableSuggestions: false,
            hintText: 'Password',
            focusNode: _focusPassword,
            borderRadius: 5,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            maxLines: 1,
            ignoreShadow: true,
            obscureText: true,
            onChanged: (value) => {},
            onFieldSubmitted: (text) {},
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 10),
          buildSignUpButton(),
        ],
      ),
    );
  }

  Widget buildSignUpButton() {
    return Flexible(
      child: TCBottomButton(
        color: context.colorScheme.primary,
        title: 'Create account',
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(EmailRegisterRequest(
            email: _emailController.text,
            password: _passwordController.text,
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildHeader(),
        buildSignUpForm(),
      ],
    );
  }
}

class TCBottomButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;
  final bool disabled;
  final bool isLoading;
  const TCBottomButton({
    super.key,
    this.isLoading = false,
    required this.title,
    required this.onPressed,
    this.color = Colors.blue,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: disabled ? null : onPressed,
        child: isLoading
            ? AppLoadingIndicator(
                radius: 15,
                color: context.colorScheme.onPrimary,
              )
            : Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ),
    );
  }
}
