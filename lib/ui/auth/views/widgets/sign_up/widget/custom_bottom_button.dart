import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';

class CustomBottomButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;
  final bool disabled;
  final bool isLoading;
  const CustomBottomButton({
    super.key,
    this.isLoading = false,
    required this.title,
    required this.onPressed,
    this.color = Colors.blue,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: disabled ? null : onPressed,
        child: isLoading
            ? AppLoadingIndicator(
                radius: 15,
                color: context.colorScheme.onPrimary,
              )
            : Text(
                title.toUpperCase(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
