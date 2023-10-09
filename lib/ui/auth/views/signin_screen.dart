import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/views/signup_screen.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_scaffold_body.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_textfield.dart';
import 'package:logger/logger.dart';

import 'widgets/custom_scaffold_appbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusUsernameEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();
  late final authBloc = BlocProvider.of<AuthBloc>(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusUsernameEmail.dispose();
    _focusPassword.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget buildBackgroundView() {
    return Container(
      width: double.infinity,
      color: context.colorScheme.background,
    );
  }

  Widget buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/images/splash.png", cacheHeight: 70),
        RichText(
          text: TextSpan(
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
            ),
            children: [
              const TextSpan(text: 'Welcome to '),
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
        const SizedBox(height: 15),
        Text(
          'Sign In',
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildSignInForm() {
    var fillColor = context.colorScheme.onBackground;
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.3,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter your username or email address',
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
            hintText: 'Username or email address',
            clearTextIcon: Icon(Icons.close),
            focusNode: _focusUsernameEmail,
            borderRadius: 5,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            maxLines: 1,
            ignoreShadown: true,
            onFieldSubmitted: (text) {},
          ),
          const SizedBox(height: 16),
          Text(
            'Enter your Password',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TCInputField(
            height: 45,
            autocorrect: false,
            enableSuggestions: false,
            fillColor: fillColor,
            onChanged: (value) => {},
            focusNode: _focusPassword,
            obscureText: true,
            maxLines: 1,
            borderRadius: 5,
            textInputAction: TextInputAction.send,
            controller: _passwordController,
            ignoreShadown: true,
            onFieldSubmitted: (v) {
              _onLogin();
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Forgot Password',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAnotherSignInOption() {
    return SizedBox(
      height: Platform.isIOS
          ? MediaQuery.sizeOf(context).height * 0.35
          : MediaQuery.sizeOf(context).height * 0.25,
      child: Column(
        children: [
          buildSignInOptionButton(
            "assets/images/ic_google.svg",
            'Sign in with Google',
          ),
          const SizedBox(
            height: 16,
          ),
          if (Platform.isIOS)
            buildSignInOptionButton(
              "assets/images/ic_apple.svg",
              'Sign in with Apple',
            ),
          SizedBox(
            height: Platform.isIOS ? 16 : 0,
          ),
          buildSignInOptionButton(
            "assets/images/ic_facebook.svg",
            'Sign in with Facebook',
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {},
            child: RichText(
              text: TextSpan(
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: context.theme.hintColor,
                ),
                children: [
                  const TextSpan(text: 'No Account ? '),
                  TextSpan(
                    text: 'Sign up',
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

  Widget buildSignInButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TCBottomButton(
        color: context.colorScheme.primary,
        title: 'Sign In',
        onPressed: _onLogin,
      ),
    );
  }

  Widget buildSignInOptionButton(
    String iconPath,
    String text,
  ) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(0XFFE9F1FF),
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

  void _onLogin() {
    authBloc.add(EmailLoginRequest(
      email: "phhai@ymail.com",
      password: "123456",
    ));
    // if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    // } else {

    //   _passwordController.clear();
    // }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomScaffoldAppBar(),
      body: CustomScaffoldBody(
        child: Column(
          children: [
            buildHeader(),
            buildSignInForm(),
            buildAnotherSignInOption(),
            buildSignInButton(),
          ],
        ),
      ),
    );
  }
}
