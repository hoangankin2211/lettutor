import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class HomeItemComponent extends StatelessWidget {
  const HomeItemComponent({
    super.key,
    required this.title,
    this.trailing,
    this.verticalBodyGap = 15,
    required this.body,
    this.padding,
    this.leading,
    this.isPadding = true,
  });
  final String title;
  final Widget? trailing;
  final Widget? leading;
  final Widget body;
  final bool isPadding;
  final double verticalBodyGap;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding
          ? (padding ?? const EdgeInsets.only(top: 10, bottom: 10, left: 10))
          : EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 5),
              ],
              Text(
                title,
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
          SizedBox(height: verticalBodyGap),
          body,
        ],
      ),
    );
  }
}
