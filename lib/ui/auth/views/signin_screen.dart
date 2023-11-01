import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/blocs/auth_status.dart';
import 'package:lettutor/ui/auth/views/auth_screen.dart';
import 'package:lettutor/ui/auth/views/signup_screen.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_textfield.dart';

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
      return context.l10n.emailRequired;
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return context.l10n.pleaseEnterAddress;
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return context.l10n.passwordRequired;
    } else if (value.length < 6) {
      return context.l10n.passwordCharactersLong;
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
        const SizedBox(height: 15),
        Text(
          context.l10n.signIn,
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
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.entUsernameEmail,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(decorationColor: context.colorScheme.primary),
              // labelText: labelText,
              hintText: context.l10n.usernameEmail,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).dividerColor, width: 1.5),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: context.colorScheme.primary, width: 1.5),
                gapPadding: 10,
              ),
            ),
            validator: (value) => validateEmail(value ?? ""),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.enterPassword,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(decorationColor: context.colorScheme.primary),
              // labelText: labelText,
              hintText: context.l10n.usernameEmail,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).dividerColor, width: 1.5),
                gapPadding: 10,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: context.colorScheme.primary, width: 1.5),
                gapPadding: 10,
              ),
            ),
            textInputAction: TextInputAction.send,
            validator: (value) => validatePassword(value ?? ""),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                context.l10n.forgotPassword,
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
      // height: Platform.isIOS
      //     ? MediaQuery.sizeOf(context).height * 0.35
      //     : MediaQuery.sizeOf(context).height * 0.25,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSignInOptionButton(
            "assets/images/ic_google.svg",
            context.l10n.signInGoogle,
          ),
          const SizedBox(
            height: 16,
          ),
          if (Platform.isIOS)
            buildSignInOptionButton(
              "assets/images/ic_apple.svg",
              context.l10n.signInApple,
            ),
          SizedBox(
            height: Platform.isIOS ? 16 : 0,
          ),
          buildSignInOptionButton(
            "assets/images/ic_facebook.svg",
            context.l10n.signInFace,
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

  Widget buildSignInButton(AuthState authState) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TCBottomButton(
        isLoading: authState.isLoading,
        color: context.colorScheme.primary,
        title: context.l10n.signIn,
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
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
