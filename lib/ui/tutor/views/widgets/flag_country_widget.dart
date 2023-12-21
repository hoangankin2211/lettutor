import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';

class FlagCountryWidget extends StatelessWidget {
  const FlagCountryWidget({
    super.key,
    required this.country,
  });

  final String country;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CountryFlag.fromCountryCode(
          country.toUpperCase(),
          height: 25,
          width: 45,
          borderRadius: 8,
        ),
        Flexible(
          child: Text(
            Country.tryParse(country)?.name ?? "Unknown",
            style: context.textTheme.bodyLarge,
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
