// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/blocs/auth_status.dart';
import 'package:lettutor/ui/auth/views/widgets/forget_password/forget_password_widget.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_up/widget/custom_bottom_button.dart';

import 'widget/sign_in_form_widget.dart';
import 'widget/sign_in_header.dart';
import 'widget/sign_in_option_widget.dart';

class SignInScreen extends StatefulWidget {
  final bool isSignInForm;
  final VoidCallback? openForgetPassword;
  final VoidCallback? openSignInForm;

  const SignInScreen({
    Key? key,
    this.isSignInForm = true,
    this.openForgetPassword,
    this.openSignInForm,
  }) : super(key: key);

  @override
  State createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthenticationBloc get authBloc => context.read<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
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
            children: [
              const SignInHeader(),
              const SizedBox(height: 10),
              Flexible(
                child: widget.isSignInForm
                    ? Column(
                        children: [
                          Text(
                            context.l10n.signIn,
                            style: context.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Flexible(
                            child: SignInFormWidget(
                              emailController: _emailController,
                              passwordController: _passwordController,
                              openForgetPassword: widget.openForgetPassword,
                            ),
                          ),
                          buildSignInButton(state),
                          const Expanded(
                              child: Center(child: SignInOptionWidget())),
                        ]
                            .expand<Widget>((element) =>
                                [element, const SizedBox(height: 5)])
                            .toList(),
                      )
                    : ForgetPasswordForm(openSignInForm: widget.openSignInForm),
              ),
            ],
          ),
        );
      },
    );
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

  Widget buildSignInButton(AuthenticationState authState) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomBottomButton(
        isLoading: authState.isLoading,
        color: context.colorScheme.primary,
        title: context.l10n.signIn,
        onPressed: _onLogin,
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
