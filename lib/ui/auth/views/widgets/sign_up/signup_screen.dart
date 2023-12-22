import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/blocs/auth_status.dart';
import 'package:lettutor/ui/auth/views/page_controller.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_in/widget/sign_in_option_widget.dart';
import 'widget/sign_up_form.dart';
import 'widget/sign_up_header.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const int pageNum = 1;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated &&
            (state.message?.isNotEmpty ?? false)) {
          context.showSnackBarAlert(state.message!);
        }

        if (state.authStatus == AuthStatus.registerSuccess) {
          context.showSnackBarAlert("Register success");
          context.read<AuthPageController>().openSignIn();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SignUpHeader(),
          const SignUpForm(),
          const SizedBox(height: 16),
          SignInOptionWidget(
            otherChoice: "Already have an account? ",
            onTapOtherChoice: context.read<AuthPageController>().openSignIn,
          ),
        ],
      ),
    );
  }
}
