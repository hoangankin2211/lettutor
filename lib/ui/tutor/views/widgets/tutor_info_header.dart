import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/ui/tutor/views/tutor_detail_screen.dart';

class TutorInfoHeader extends StatefulWidget {
  const TutorInfoHeader({
    super.key,
    required this.avatar,
    required this.name,
    required this.numOfFeedback,
    required this.country,
    required this.profession,
    this.radius = 40,
  });

  final String avatar;
  final String name;
  final String profession;
  final int numOfFeedback;
  final String country;
  final double radius;

  @override
  State<TutorInfoHeader> createState() => _TutorInfoHeaderState();
}

class _TutorInfoHeaderState extends State<TutorInfoHeader> {
  late String _avatar = widget.avatar;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: widget.radius,
          foregroundImage: NetworkImage(_avatar),
          onForegroundImageError: (exception, stackTrace) {
            setState(() {
              _avatar =
                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
            });
          },
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: context.textTheme.titleLarge?.boldTextTheme,
            ),
            Text(
              widget.profession,
              style: context.textTheme.bodyLarge,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CountryFlag.fromCountryCode(
                  widget.country.toUpperCase(),
                  height: 25,
                  width: 45,
                  borderRadius: 8,
                ),
                Text(
                  Country.tryParse(widget.country)?.name ?? "Unknown",
                  style: context.textTheme.bodyLarge,
                )
              ],
            ),
          ]
              .expand<Widget>((element) => [element, const SizedBox(height: 5)])
              .toList(),
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => const Icon(
              Icons.star,
              color: Colors.orangeAccent,
              size: 16,
            ),
          )
              .expand<Widget>((element) => [element, const SizedBox(width: 4)])
              .toList()
            ..add(Text(
              "(${widget.numOfFeedback})",
              style: context.textTheme.titleMedium,
            )),
        ),
      ],
    );
  }
}
