import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/blocs/auth_status.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_textfield.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_up/widget/custom_bottom_button.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key, this.openSignInForm});
  final VoidCallback? openSignInForm;

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final emailController = TextEditingController();
  AuthenticationBloc get authBloc =>
      BlocProvider.of<AuthenticationBloc>(context);

  String? validateEmail(BuildContext context, {required String value}) {
    if (value.isEmpty) {
      return context.l10n.emailRequired;
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return context.l10n.pleaseEnterAddress;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              context.l10n.resetPassword,
              style: context.textTheme.headlineMedium?.boldTextTheme,
            ),
            state.authStatus == AuthStatus.sendEmailSuccess
                ? Text(
                    context.l10n.checkEmail,
                    style: context.textTheme.bodyLarge,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          context.l10n.pleaseEnterYourPass,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          context.l10n.email,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      TCInputField(
                        fillColor: context.colorScheme.onBackground,
                        autocorrect: false,
                        controller: emailController,
                        enableSuggestions: false,
                        hintText: context.l10n.usernameEmail,
                        borderRadius: 5,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        ignoreShadow: true,
                        validator: (value) =>
                            validateEmail(context, value: value ?? ""),
                      ),
                      CustomBottomButton(
                        isLoading: state.isLoading,
                        color: context.colorScheme.primary,
                        title: context.l10n.sendEmail,
                        onPressed: () {
                          if (emailController.text.isNotEmpty) {
                            authBloc.add(
                                ForgetPasswordRequest(emailController.text));
                          }
                        },
                      ),
                    ]
                        .expand(
                            (element) => [element, const SizedBox(height: 15)])
                        .toList(),
                  ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: widget.openSignInForm,
                icon: const Icon(Icons.arrow_back_ios),
                label: Text(context.l10n.backToSignIn),
              ),
            )
          ]
              .expand<Widget>(
                (element) => [element, const SizedBox(height: 10)],
              )
              .toList(),
        );
      },
    );
  }
}
