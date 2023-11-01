import 'package:flutter/material.dart';
import 'package:lettutor/generated/l10n.dart';
import 'package:path/path.dart';

extension BuildContextExt on BuildContext {
  MediaQueryData get query {
    return MediaQuery.of(this);
  }

  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  FocusScopeNode get focus {
    return FocusScope.of(this);
  }

  ThemeData get theme {
    return Theme.of(this);
  }

  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }

  TextTheme get textTheme => theme.textTheme;

  NavigatorState get navigator {
    return Navigator.of(this);
  }

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  bool get isBigScreen {
    return query.size.width >= 768;
  }

  S get l10n => S.of(this);

  TextStyle? myTitleLarge({Color? color}) => textTheme.titleLarge?.copyWith(
        color: color ?? textTheme.titleLarge?.color,
        fontWeight: FontWeight.bold,
      );
  TextStyle? get hintBoldText => textTheme.bodyLarge
      ?.copyWith(fontWeight: FontWeight.w500, color: theme.hintColor);
}

extension FastShowSheet on BuildContext {
  void showAppModalBottomSheet(
      {required Widget Function(BuildContext) builder}) {
    showModalBottomSheet(
      context: this,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      constraints: BoxConstraints(
          maxHeight: height * 0.6, minHeight: height * 0.4, minWidth: width),
      clipBehavior: Clip.hardEdge,
      builder: builder,
    );
  }

  void showSnackBarAlert(String content) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: theme.cardColor,
        content: Text(
          content,
          style: textTheme.bodyLarge,
        ),
      ),
    );
  }

  Future<dynamic> showAppDatePicker() {
    return showDatePicker(
      context: this,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      confirmText: "Select",
      cancelText: "Cancel",
    );
  }
}

extension CustomTextTheme on TextStyle {
  TextStyle get boldTextTheme => copyWith(fontWeight: FontWeight.bold);
}

extension ConvertMap on Map {
  Map<String, dynamic> convertMapDynamicToString() {
    Map<String, dynamic> outputMap = {};

    forEach((key, value) {
      if (key is String) {
        outputMap[key] = value;
      } else {
        // Convert the key to a string before adding to the output map.
        outputMap[key.toString()] = value;
      }
    });

    return outputMap;
  }
}
