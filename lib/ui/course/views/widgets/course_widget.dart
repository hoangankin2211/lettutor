import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class CourseWidget extends StatelessWidget {
  const CourseWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subTitle,
      required this.level});

  final String? imageUrl;
  final String? title;
  final String? subTitle;
  final String? level;

  Widget _buildImage(BuildContext context) {
    return imageUrl != null
        ? ConstrainedBox(
            constraints: BoxConstraints(maxHeight: context.height * 0.22),
            child: Ink.image(
              fit: BoxFit.cover, // Fixes border issues
              image: NetworkImage(imageUrl!),
            ),
          )
        : const Placeholder();
  }

  _buildTitle(BuildContext context) {
    return Text(
      title ?? "",
      style:
          context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  _buildSubTitle(BuildContext context) {
    return Text(
      subTitle ?? "",
      style: context.textTheme.titleSmall?.copyWith(
        color: context.theme.disabledColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  _buildDegree(
    BuildContext context, {
    MaterialAccentColor color = Colors.orangeAccent,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        5,
        (index) => Container(
          height: 4 + index * 4,
          width: 4,
          color: index < 3 ? color : color.shade100.withOpacity(0.5),
        ),
      )
          .expand((element) => [
                element,
                const SizedBox(width: 2),
              ])
          .toList(),
    );
  }

  _buildDifficulty(BuildContext context,
      {MaterialAccentColor color = Colors.orangeAccent}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildDegree(context),
        const SizedBox(width: 10),
        Text(
          level ?? "",
          style: context.textTheme.bodyLarge?.copyWith(
            color: color.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: context.theme.cardColor,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {},
        child: Container(
          constraints: BoxConstraints(maxWidth: context.width * 0.85),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: context.theme.hintColor.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: _buildImage(context)),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTitle(context),
                    _buildSubTitle(context),
                    const SizedBox(height: 20),
                    _buildDifficulty(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
