import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/widgets/custom_appbar.dart';
import 'package:lettutor/core/utils/widgets/custom_stack_scroll.dart';
import 'package:lettutor/ui/auth/views/signin_screen.dart';
import 'package:lettutor/ui/auth/views/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageNotifier(pageController),
      child: Scaffold(
        resizeToAvoidBottomInset:true,
        body: CustomTemplateScreenStackScroll(
          color: context.colorScheme.primary,
          appBar: AppBarCustom(
            expandedHeight: context.height * 0.2,
            backgroundColor: context.colorScheme.primary,
          ),
          children: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(15),
                height: context.height * 0.8 - context.query.viewPadding.top,
                decoration: BoxDecoration(
                  color: context.theme.scaffoldBackgroundColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: const [
                    SignInScreen(),
                    SignUpScreen(),
                  ],
                ),
              ),
            ),
          ],
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
