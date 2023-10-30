import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/blocs/auth_status.dart';
import 'package:lettutor/ui/auth/views/auth_screen.dart';
import 'package:lettutor/ui/auth/views/signup_screen.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_scaffold_body.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_textfield.dart';
import 'package:logger/logger.dart';

import 'widgets/custom_scaffold_appbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const int pageNum = 0;

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
  final GlobalKey<FormState> formKey = GlobalKey();

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

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 8 characters long';
    }
    return null;
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
            validator: (value) => validateEmail(value ?? ""),
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
            ignoreShadow: true,
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
            autocorrect: false,
            enableSuggestions: false,
            fillColor: fillColor,
            validator: (value) => validatePassword(value ?? ""),
            onChanged: (value) => {},
            focusNode: _focusPassword,
            obscureText: true,
            maxLines: 1,
            borderRadius: 5,
            textInputAction: TextInputAction.send,
            controller: _passwordController,
            ignoreShadow: true,
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
            onTap: () {
              BlocProvider.of<PageNotifier>(context)
                  .nextPage(SignUpScreen.pageNum);
            },
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

  Widget buildSignInButton(AuthState authState) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TCBottomButton(
        isLoading: authState.isLoading,
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
    if (formKey.currentState?.validate() ?? false) {
      authBloc.add(EmailLoginRequest(
        // email: "phhai@ymail.com",
        // password: "123456",
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
    // if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    // } else {

    //   _passwordController.clear();
    // }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  final appBar = const CustomScaffoldAppBar();

  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated &&
            (state.message?.isNotEmpty ?? false)) {
          context.showSnackBarAlert(state.message!);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildHeader(),
              buildSignInForm(),
              buildAnotherSignInOption(),
              buildSignInButton(state),
            ],
          ),
        );
      },
    );
  }
}
