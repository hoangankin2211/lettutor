import 'package:flutter/cupertino.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';

class SpecialtiesComponent extends StatelessWidget {
  const SpecialtiesComponent({
    super.key,
    required this.specialty,
  });
  final String specialty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        color: context.theme.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        specialty,
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.theme.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
