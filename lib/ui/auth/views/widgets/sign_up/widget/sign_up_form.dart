import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_up/widget/custom_bottom_button.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_textfield.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  Widget buildSignUpButton(BuildContext context) {
    return Flexible(
      child: CustomBottomButton(
        color: context.colorScheme.primary,
        title: context.l10n.createAccount,
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(EmailRegisterRequest(
            email: _emailController.text,
            password: _passwordController.text,
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            context.l10n.emailAddress,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TCInputField(
            height: 45,
            fillColor: context.colorScheme.onBackground,
            autocorrect: false,
            controller: _emailController,
            enableSuggestions: false,
            hintText: context.l10n.emailAddress,
            focusNode: _focusEmail,
            borderRadius: 5,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            ignoreShadow: true,
            onChanged: (value) => {},
            onFieldSubmitted: (text) {},
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.yourPassword,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TCInputField(
            height: 45,
            fillColor: context.colorScheme.onBackground,
            autocorrect: false,
            controller: _passwordController,
            enableSuggestions: false,
            hintText: context.l10n.password,
            focusNode: _focusPassword,
            borderRadius: 5,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            maxLines: 1,
            ignoreShadow: true,
            obscureText: true,
            onChanged: (value) => {},
            onFieldSubmitted: (text) {},
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 10),
          buildSignUpButton(context),
        ],
      ),
    );
  }
}
