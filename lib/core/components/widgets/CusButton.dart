import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class CusButton extends StatelessWidget {
  const CusButton({super.key, required this.onPressed, required this.child});
  final VoidCallback onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 0,
        backgroundColor: context.theme.primaryColor.withOpacity(0.3),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: context.theme.primaryColor,
            width: 0.2,
          ),
        ),
      ),
      child: child,
    );
  }
}
