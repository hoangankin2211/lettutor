import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettutor/core/core.dart';

class CustomScaffoldAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double? width;
  final double height;
  final double elevation;
  final Color? backgroundColor;

  const CustomScaffoldAppBar({
    Key? key,
    this.height = 0,
    this.elevation = 0,
    this.width,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  static SystemUiOverlayStyle commonOverlayStyleWithColorAndBrigtness(
      BuildContext context, Color color) {
    if (Theme.of(context).brightness == Brightness.light) {
      return SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: color == context.colorScheme.background
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: Brightness.light,
      );
    }

    return SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color defaultColor = context.colorScheme.primary;

    return PreferredSize(
      preferredSize: Size(width ?? MediaQuery.of(context).size.width, height),
      child: AppBar(
        backgroundColor: backgroundColor ?? defaultColor,
        elevation: elevation,
        systemOverlayStyle:
            commonOverlayStyleWithColorAndBrigtness(context, defaultColor),
      ),
    );
  }
}
