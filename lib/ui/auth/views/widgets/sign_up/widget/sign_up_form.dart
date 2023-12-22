import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/auth/views/widgets/sign_up/widget/custom_bottom_button.dart';
import 'package:lettutor/ui/auth/views/widgets/custom_textfield.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthenticationBloc get authBloc =>
      BlocProvider.of<AuthenticationBloc>(context);

  final FocusNode _focusEmail = FocusNode();

  final FocusNode _focusPassword = FocusNode();

  Widget buildSignUpButton(BuildContext context, bool isLoading) {
    return Flexible(
      child: CustomBottomButton(
        isLoading: isLoading,
        color: context.colorScheme.primary,
        title: context.l10n.createAccount,
        onPressed: () {
          authBloc.add(EmailRegisterRequest(
            email: _emailController.text,
            password: _passwordController.text,
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 10),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return buildSignUpButton(
              context,
              state.isLoading,
            );
          },
        ),
      ],
    );
  }
}
