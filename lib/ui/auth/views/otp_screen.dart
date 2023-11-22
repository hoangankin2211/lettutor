import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/core/core.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'widgets/sign_up/widget/custom_bottom_button.dart';
import 'widgets/custom_scaffold_appbar.dart';
import 'widgets/custom_scaffold_body.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void dispose() {
    _pinCodeController.dispose();
    super.dispose();
  }

  Widget buildHeader() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(text: context.l10n.welcomeTo),
              TextSpan(
                text: 'LetTutor'.toUpperCase(),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          context.l10n.otpVerification,
          style: context.textTheme.headlineSmall,
        ),
      ],
    );
  }

  Widget buildInputOTPCodeField() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.1),
              radius: 40,
              child: SvgPicture.asset(
                "assets/images/ic_lock.svg",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Enter the OTP Code',
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 18,
              ),
            ),
            Text(
              'We\'ve sent you an OTP code to email',
              style: context.textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
            Text(
              'minmin@hanbiro.com',
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildOTPField()
          ],
        ),
      ),
    );
  }

  Widget buildOTPField() {
    return PinCodeTextField(
      appContext: context,
      controller: _pinCodeController,
      enableActiveFill: true,
      length: 6,
      cursorColor: context.colorScheme.primary,
      textStyle: context.textTheme.titleLarge,
      onChanged: (value) {},
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      animationType: AnimationType.fade,
      autoDisposeControllers: false,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        activeColor: Color(0xFF006FFD),
        activeFillColor: Colors.white,
        selectedColor: Color(0xFF006FFD),
        selectedFillColor: Colors.white,
        inactiveColor: Color(0xFFADADAD),
        inactiveFillColor: Color(0xFFE9E9E9),
        disabledColor: Color(0xFFADADAD),
        fieldHeight: 40,
        fieldWidth: 40,
        borderWidth: 1,
        borderRadius: BorderRadius.circular(5),
      ),
      dialogConfig: DialogConfig(
        dialogTitle: 'Paste Code',
        dialogContent: 'Do you want to paste this code ?',
        affirmativeText: 'Paste',
        negativeText: 'Cancel',
      ),
      onCompleted: (v) {},
    );
  }

  Widget buildVerifyButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomBottomButton(
        color: context.colorScheme.primary,
        title: 'Verify',
        onPressed: () {
          // onLogin();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomScaffoldAppBar(),
      body: CustomScaffoldBody(
        child: Column(
          children: [
            buildHeader(),
            buildInputOTPCodeField(),
            buildVerifyButton(),
          ],
        ),
      ),
    );
  }
}
