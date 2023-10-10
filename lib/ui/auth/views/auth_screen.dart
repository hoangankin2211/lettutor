import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/auth/views/signin_screen.dart';
import 'package:lettutor/ui/auth/views/signup_screen.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_scaffold_body.dart';
import 'package:riverpod/riverpod.dart';

import 'widgets/custom_scaffold_appbar.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final appBar = const CustomScaffoldAppBar();

  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.colorScheme.primary,
      appBar: appBar,
      body: CustomScaffoldBody(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.9 -
              appBar.preferredSize.height,
          child: BlocProvider(
            create: (context) => PageNotifier(pageController),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                SignInScreen(),
                SignUpScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageNotifier extends Cubit<int> {
  final PageController pageController;

  PageNotifier(this.pageController) : super(SignInScreen.pageNum);

  void nextPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceIn,
    );
  }
}
