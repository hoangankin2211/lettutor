import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    super.key,
    required this.page,
    required this.totalPage,
    this.onBack,
    this.onNext,
  });
  final int page;
  final int totalPage;
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onBack,
          constraints: BoxConstraints(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        const SizedBox(width: 5),
        Text(
          "${NumberFormat("00").format(page)}/${NumberFormat("00").format(totalPage)}",
          style: context.textTheme.titleMedium?.boldTextTheme,
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: onNext,
          constraints: BoxConstraints(),
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
