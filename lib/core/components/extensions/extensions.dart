import 'package:flutter/material.dart';
import 'package:lettutor/generated/l10n.dart';

extension BuildContextExt on BuildContext {
  MediaQueryData get query {
    return MediaQuery.of(this);
  }

  double get width => query.size.width;

  double get height => query.size.height;

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
}
