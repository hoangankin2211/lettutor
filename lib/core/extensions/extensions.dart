import 'package:flutter/material.dart';
import 'package:lettutor/generated/l10n.dart';

extension BuildContextExt on BuildContext {
  MediaQueryData get query {
    return MediaQuery.of(this);
  }

  FocusScopeNode get focus {
    return FocusScope.of(this);
  }

  ThemeData get theme {
    return Theme.of(this);
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
