import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/constants/enum.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';
import 'package:lettutor/ui/tutor/views/widgets/flag_country_widget.dart';

import 'specialties_component.dart';

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
    this.onTap,
    this.isFavorite = false,
    this.markFavorite,
  });
  final String imageUrl;
  final String name;
  final String country;
  final List<String> specialties;
  final double rating;
  final String description;
  final double price;
  final void Function()? onTap;
  final bool isFavorite;
  final void Function(bool)? markFavorite;

  @override
  State<TutorWidget> createState() => _TutorWidgetState();
}

class _TutorWidgetState extends State<TutorWidget> {
  late String url = widget.imageUrl;

  _buildSpecialties() {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      spacing: 5,
      runSpacing: 5,
      children: widget.specialties
          .toSet()
          .expand((element) => [TutorTag.fromKey(element).name])
          .where((element) => element.isNotEmpty)
          .map(_buildSpecialtiesComponent)
          .toList(),
    );
  }

  Widget _buildSpecialtiesComponent(String specialty) {
    return SpecialtiesComponent(specialty: specialty);
  }

  ImageProvider? _buildImageProvider(String url) {
    try {
      if (url.isEmpty) return null;
      return CachedNetworkImageProvider(
        url,
        cacheKey: url,
      );
    } catch (e) {
      return null;
    }
  }

  _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
              radius: 30,
              backgroundColor: context.theme.cardColor,
              foregroundImage: _buildImageProvider(url),
              backgroundImage: const AssetImage("assets/images/user.png"),
              child: widget.imageUrl.isEmpty
                  ? Text(
                      widget.name
                          .splitMapJoin(
                            RegExp(r'\b\w'),
                            onMatch: (p0) => p0.group(0)!,
                            onNonMatch: (p0) => "",
                          )
                          .toUpperCase(),
                      style: context.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ))
                  : null),
          title: Text(
            widget.name,
            style: context.myTitleLarge(),
          ),
          subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: FlagCountryWidget(country: widget.country)),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.rating != 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.orangeAccent),
                    const SizedBox(width: 5),
                    Text(
                      widget.rating.toStringAsFixed(1),
                      style: context.textTheme.bodyLarge?.boldTextTheme,
                    )
                  ],
                )
              else
                Text(
                  context.l10n.noReviewYet,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.theme.disabledColor,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              IconButton(
                constraints: const BoxConstraints(),
                splashRadius: 8,
                padding: EdgeInsets.zero,
                onPressed: () {
                  widget.markFavorite != null
                      ? widget.markFavorite!(!widget.isFavorite)
                      : () {};
                },
                icon: widget.isFavorite
                    ? Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red.shade600,
                      )
                    : Icon(
                        CupertinoIcons.heart,
                        color: context.theme.hintColor,
                      ),
              ),
            ],
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
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  _buildActionButton() {
    return Row(
      children: [
        ElevatedBorderButton(
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
                context.l10n.book,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: context.theme.primaryColor),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          "\$${widget.price.ceil()}",
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
        onTap: widget.onTap,
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
