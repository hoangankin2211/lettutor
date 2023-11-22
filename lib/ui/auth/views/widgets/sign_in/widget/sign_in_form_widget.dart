import 'package:flutter/material.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';

class SignInFormWidget extends StatelessWidget {
  const SignInFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

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
    } else if (value.length < 6) {
      return context.l10n.passwordCharactersLong;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.entUsernameEmail,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: emailController,
            validator: (value) => validateEmail(context, value: value ?? ""),
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(decorationColor: context.colorScheme.primary),
              hintText: context.l10n.usernameEmail,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).dividerColor, width: 1.5),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: context.colorScheme.primary, width: 1.5),
                gapPadding: 10,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.enterPassword,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: passwordController,
            validator: (value) => validatePassword(context, value: value ?? ""),
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(decorationColor: context.colorScheme.primary),
              hintText: context.l10n.usernameEmail,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).dividerColor, width: 1.5),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: context.colorScheme.primary, width: 1.5),
                gapPadding: 10,
              ),
            ),
            textInputAction: TextInputAction.send,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                context.l10n.forgotPassword,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
