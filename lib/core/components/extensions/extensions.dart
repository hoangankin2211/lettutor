import 'package:flutter/material.dart';
import 'package:lettutor/generated/l10n.dart';

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

  void showSnackBarAlert(String content) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(content)));
  }

  void showAppModalBottomSheet(
      {required Widget Function(BuildContext) builder}) {
    showModalBottomSheet(
      context: this,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.hardEdge,
      builder: builder,
    );
  }
}

extension CustomTextTheme on TextStyle {
  TextStyle get boldTextTheme => copyWith(fontWeight: FontWeight.bold);
}
