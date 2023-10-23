import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class ElevatedBorderButton extends StatelessWidget {
  const ElevatedBorderButton({
    super.key,
    this.onPressed,
    required this.child,
    this.borderColor,
    this.backgroundColor,
  });
  final VoidCallback? onPressed;
  final Widget child;
  final Color? borderColor;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 0,
        foregroundColor: Colors.transparent,
        backgroundColor: backgroundColor ?? context.colorScheme.onPrimary,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: borderColor ?? context.theme.primaryColor,
            width: 1,
          ),
        ),
      ),
      child: child,
    );
  }
}
