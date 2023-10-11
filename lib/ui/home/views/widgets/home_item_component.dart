import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class HomeItemComponent extends StatelessWidget {
  const HomeItemComponent({
    super.key,
    required this.title,
    this.trailing,
    required this.body,
    this.padding,
    this.leading,
  });
  final String title;
  final Widget? trailing;
  final Widget? leading;
  final Widget body;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 10, bottom: 10, left: 10),
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
          const SizedBox(height: 15),
          body,
        ],
      ),
    );
  }
}
