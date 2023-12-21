import 'package:flutter/material.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';

class ElevatedBorderButton extends StatelessWidget {
  const ElevatedBorderButton({
    super.key,
    this.onPressed,
    required this.child,
    this.borderColor,
    this.backgroundColor,
    this.width,
  });
  final VoidCallback? onPressed;
  final Widget child;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: width != null ? Size(width!, 40) : null,
        disabledBackgroundColor:
            backgroundColor ?? context.colorScheme.onPrimary,
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
