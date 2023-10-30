import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.color, this.radius});
  final Color? color;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: radius,
        width: radius,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      ),
    );
  }
}
