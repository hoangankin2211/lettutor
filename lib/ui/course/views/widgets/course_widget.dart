import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class CourseWidget extends StatelessWidget {
  const CourseWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subTitle,
      required this.level});
  final String imageUrl;
  final String title;
  final String subTitle;
  final String level;

  Widget _buildImage() {
    return Container(
      height: 180,
      width: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return Text(
      title,
      style:
          context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  _buildSubTitle(BuildContext context) {
    return Text(
      subTitle,
      style: context.textTheme.titleSmall?.copyWith(
        color: context.theme.disabledColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  _buildDegree(BuildContext context,
      {MaterialAccentColor color = Colors.orangeAccent}) {
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
            .toList());
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
          level,
          style: context.textTheme.bodyLarge?.copyWith(
            color: color.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: context.width * 0.85, maxHeight: 180),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        border: Border.all(
          color: context.theme.hintColor.withOpacity(0.1),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: _buildImage()),
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
    );
  }
}
