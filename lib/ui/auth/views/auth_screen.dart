import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/utils/widgets/custom_appbar.dart';
import 'package:lettutor/core/utils/widgets/custom_stack_scroll.dart';
import 'package:lettutor/ui/auth/views/page_controller.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_in/signin_screen.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_up/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static const int initialPage = 0;
  final pageController =
      PageController(initialPage: initialPage, keepPage: false);

  late final listPageWidget = [
    const SignInScreen(),
    const SignUpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthPageController(pages: listPageWidget, initialPage: initialPage),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomTemplateScreenStackScroll(
          color: context.colorScheme.primary,
          afterMainScreen: SvgPicture.asset(
              "assets/images/ic_lettutor_anytime_anywhere.svg"),
          appBar: AppBarCustom(
            expandedHeight: context.height * 0.3,
            backgroundColor: Colors.transparent,
          ),
          children: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(15),
                height: context.height * 0.7 - context.query.viewPadding.top,
                decoration: BoxDecoration(
                  color: context.theme.scaffoldBackgroundColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: BlocListener<AuthPageController, int>(
                  listener: (context, page) {
                    logger.d("Page: $page");
                    pageController.animateToPage(
                      page,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    children: listPageWidget,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
