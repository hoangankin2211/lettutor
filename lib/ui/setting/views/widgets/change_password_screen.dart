import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  AuthenticationBloc get authBloc =>
      BlocProvider.of<AuthenticationBloc>(context);

  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authBloc.add(InitChangePasswordFlow());
    super.initState();
  }

  String? validatePassword(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return context.l10n.passwordRequired;
      } else if (value.length < 6) {
        return context.l10n.passwordCharactersLong;
      }
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != null) {
      if (value != newPasswordController.text) {
        return context.l10n.passwordNotMatch;
      }
    }
    return null;
  }

  void _onChangePassword() {
    if (_formKey.currentState!.validate()) {
      authBloc.add(ChangePasswordRequest(
        password: oldPasswordController.text,
        newPassword: newPasswordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          context.l10n.changePassword,
          style: context.textTheme.titleLarge?.boldTextTheme,
        ),
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(Icons.arrow_back_ios,
              color: context.textTheme.titleLarge?.color),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is ChangePassword) {
            switch (state.changePasswordStatus) {
              case ChangePasswordStatus.success:
                logger.d(state.changePasswordStatus);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      "Successfully",
                      style: context.textTheme.titleMedium,
                    ),
                    content: Text(
                      state.message ?? "Change password successfully",
                      style: context.textTheme.bodyLarge,
                    ),
                    actions: [
                      TextButton(
                        onPressed: context.pop,
                        child: Text("Ok", style: context.textTheme.bodyLarge),
                      ),
                    ],
                  ),
                );
                break;

              case ChangePasswordStatus.fail:
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      "Change password fail",
                      style: context.textTheme.titleMedium,
                    ),
                    content: Text(
                      state.message ?? "Something went wrong",
                      style: context.textTheme.bodyLarge,
                    ),
                    actions: [
                      TextButton(
                        onPressed: context.pop,
                        child: Text("Ok", style: context.textTheme.bodyLarge),
                      ),
                    ],
                  ),
                );
                break;
              default:
                break;
            }
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PasswordField(
                    validator: validatePassword,
                    controller: oldPasswordController,
                    labelText: context.l10n.oldPassword,
                    hintText: context.l10n.enterOldPassword,
                    iconData: Icons.lock,
                  ),
                  PasswordField(
                    controller: newPasswordController,
                    validator: validatePassword,
                    labelText: context.l10n.newPassword,
                    hintText: context.l10n.enterNewPassword,
                    iconData: Icons.lock,
                  ),
                  PasswordField(
                    controller: confirmPasswordController,
                    validator: validateConfirmPassword,
                    labelText: context.l10n.confirmPassword,
                    hintText: context.l10n.enterConfirmPassword,
                    iconData: Icons.lock,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: context.width,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _onChangePassword();
                        context
                            .showSnackBarAlert("Change password successfully");
                      },
                      child:
                          (state is ChangePassword && state.isChangingPassword)
                              ? AppLoadingIndicator(
                                  color: context.colorScheme.onPrimary,
                                  radius: 10,
                                )
                              : Text(
                                  context.l10n.changePassword,
                                  style: context
                                      .textTheme.titleMedium?.boldTextTheme
                                      .copyWith(
                                          color: context.colorScheme.onPrimary),
                                ),
                    ),
                  ),
                ]
                    .expand((element) => [
                          element,
                          const SizedBox(height: 10),
                        ])
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  PasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.iconData,
    this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? iconData;
  final String? Function(String?)? validator;

  final ValueNotifier<bool> isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                color: context.theme.hintColor,
                size: 25,
              ),
            const SizedBox(width: 5),
            Text(
              labelText,
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        ValueListenableBuilder<bool>(
          valueListenable: isObscure,
          builder: (context, value, child) => TextFormField(
            obscureText: value,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () => isObscure.value = !isObscure.value,
                icon: Icon(
                  value ? Icons.visibility : Icons.visibility_off,
                  color: context.theme.hintColor,
                ),
              ),
              labelStyle:
                  TextStyle(decorationColor: context.colorScheme.primary),
              hintText: hintText,
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
        ),
      ],
    );
  }
}
