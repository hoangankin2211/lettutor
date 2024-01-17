import 'package:flutter/material.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_textfield.dart';

class SignInFormWidget extends StatelessWidget {
  const SignInFormWidget({
    super.key,
    this.openForgetPassword,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback? openForgetPassword;

  String? validateEmail(BuildContext context, {required String value}) {
    if (value.isEmpty) {
      return context.l10n.emailRequired;
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return context.l10n.pleaseEnterAddress;
    }
    return null;
  }

  String? validatePassword(BuildContext context, {required String value}) {
    if (value.isEmpty) {
      return context.l10n.passwordRequired;
    } else if (value.length < 5) {
      return context.l10n.passwordCharactersLong;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          context.l10n.entUsernameEmail,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TCInputField(
          fillColor: context.colorScheme.onPrimary,
          autocorrect: false,
          controller: emailController,
          enableSuggestions: false,
          hintText: context.l10n.usernameEmail,
          borderRadius: 5,
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          ignoreShadow: true,
          validator: (value) => validateEmail(context, value: value ?? ""),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.enterPassword,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TCInputField(
          fillColor: context.colorScheme.onPrimary,
          autocorrect: false,
          controller: passwordController,
          enableSuggestions: false,
          hintText: context.l10n.password,
          borderRadius: 5,
          textInputAction: TextInputAction.send,
          keyboardType: TextInputType.text,
          maxLines: 1,
          ignoreShadow: true,
          obscureText: true,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: openForgetPassword,
            child: Text(
              context.l10n.forgotPassword,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
