import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_in/signin_screen.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_up/signup_screen.dart';

class AuthPageController extends Cubit<int> {
  final List<Widget> pages;

  AuthPageController({
    required this.pages,
    required int initialPage,
  }) : super(initialPage);

  void openSignIn() {
    int page = pages.indexWhere((widget) => widget.runtimeType == SignInScreen);
    print(page);

    if (page == -1) return;
    emit(page);
  }

  void openSignUp() {
    int page = pages.indexWhere((widget) => widget.runtimeType == SignUpScreen);
    if (page == -1) return;
    emit(page);
  }
}
