import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widget/sign_up_form.dart';
import 'widget/sign_up_header.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const int pageNum = 1;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SignUpHeader(),
        SignUpForm(
          emailController: _emailController,
          passwordController: _passwordController,
        ),
      ],
    );
  }
}
