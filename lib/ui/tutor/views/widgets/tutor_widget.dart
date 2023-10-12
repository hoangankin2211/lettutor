import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/widgets/CusButton.dart';

class TutorWidget extends StatefulWidget {
  const TutorWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.country,
    required this.specialties,
    required this.rating,
    required this.description,
    required this.price,
  });
  final String imageUrl;
  final String name;
  final String country;
  final List<String> specialties;
  final double rating;
  final String description;
  final double price;

  @override
  State<TutorWidget> createState() => _TutorWidgetState();
}

class _TutorWidgetState extends State<TutorWidget> {
  _buildSpecialties() {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      spacing: 5,
      runSpacing: 5,
      children: widget.specialties.map(_buildSpecialtiesComponent).toList(),
    );
  }

  Widget _buildSpecialtiesComponent(String specialty) {
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

  _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
              ),
            ),
          ),
          title: Text(
            widget.name,
            style: context.myTitleLarge(),
          ),
          subtitle: Row(
            children: [
              Icon(Icons.flag),
              Text(
                widget.country,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.theme.disabledColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          trailing: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.orangeAccent),
                    const SizedBox(width: 5),
                    Text(
                      widget.rating.toString(),
                      style: context.textTheme.bodyLarge?.boldTextTheme,
                    )
                  ],
                ),
                Icon(
                  CupertinoIcons.heart,
                  color: context.theme.hintColor,
                ),
              ],
            ),
          ),
        ),
        _buildSpecialties(),
      ],
    );
  }

  _buildDescription() {
    return Text(
      widget.description,
      style: context.hintBoldText,
    );
  }

  _buildActionButton() {
    return Row(
      children: [
        CusButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_month,
                color: context.theme.primaryColor,
              ),
              const SizedBox(width: 5),
              Text(
                "Book",
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: context.theme.primaryColor),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          "\$${widget.price.toString()}",
          style: context.textTheme.titleLarge,
        )
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
          constraints: BoxConstraints(maxWidth: context.width * 0.8),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: context.theme.hintColor.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildDescription(),
              _buildActionButton(),
            ]
                .expand<Widget>(
                  (element) => [
                    element,
                    const SizedBox(height: 10),
                  ],
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
