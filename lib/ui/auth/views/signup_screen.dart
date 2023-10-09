import 'package:flutter/material.dart';
import 'package:lettutor/core/core.dart';

import 'widgets/custom_scaffold_appbar.dart';
import 'widgets/custom_scaffold_body.dart';
import 'widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  final FocusNode _focusFirstName = FocusNode();
  final FocusNode _focusLastName = FocusNode();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();
  final FocusNode _focusConfirmPwd = FocusNode();

  Widget buildBackgroundView() {
    return Container(
      width: double.infinity,
      color: context.colorScheme.background,
    );
  }

  Widget buildHeader() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(text: 'Welcome to '),
              TextSpan(
                text: 'TeamChannel'.toUpperCase(),
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
    );
  }

  Widget buildSignUpForm() {
    var fillColor = context.colorScheme.onBackground;
    return Expanded(
      // height: MediaQuery.sizeOf(context).height * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'First name',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TCInputField(
              height: 45,
              fillColor: fillColor,
              autocorrect: false,
              controller: _firstNameController,
              enableSuggestions: false,
              hintText: 'First name',
              focusNode: _focusFirstName,
              borderRadius: 5,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              maxLines: 1,
              ignoreShadown: true,
              onFieldSubmitted: (text) {},
            ),
            const SizedBox(height: 16),
            Text(
              'Last name',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TCInputField(
              height: 45,
              fillColor: fillColor,
              autocorrect: false,
              controller: _lastNameController,
              enableSuggestions: false,
              hintText: 'Last name',
              focusNode: _focusLastName,
              borderRadius: 5,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              maxLines: 1,
              ignoreShadown: true,
              onFieldSubmitted: (text) {},
            ),
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
              ignoreShadown: true,
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
              ignoreShadown: true,
              obscureText: true,
              onChanged: (value) => {},
              onFieldSubmitted: (text) {},
            ),
            const SizedBox(height: 16),
            Text(
              'Confirm password',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TCInputField(
              height: 45,
              fillColor: fillColor,
              autocorrect: false,
              controller: _confirmPwdController,
              enableSuggestions: false,
              hintText: 'Password',
              focusNode: _focusConfirmPwd,
              borderRadius: 5,
              keyboardType: TextInputType.text,
              maxLines: 1,
              ignoreShadown: true,
              obscureText: true,
              onFieldSubmitted: (v) {},
            ),
            const SizedBox(height: 10),
            buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget buildSignUpButton() {
    return Flexible(
      child: TCBottomButton(
        color: context.colorScheme.primary,
        title: 'Create account',
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomScaffoldAppBar(height: 40),
      body: CustomScaffoldBody(
        child: Column(
          children: [
            buildHeader(),
            buildSignUpForm(),
          ],
        ),
      ),
    );
  }
}

class TCBottomButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;
  final bool disabled;
  const TCBottomButton({
    super.key,
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
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
