import 'package:flutter/material.dart';

import 'custom_appbar.dart';

class CustomTemplateScreenStackScroll extends StatefulWidget {
  final List<Widget> children;
  final AppBarCustom? appBar;
  final EdgeInsetsGeometry? paddingAll;
  final EdgeInsetsGeometry? paddingView;
  final Color? color;
  final Widget? bottomSheet;
  final Widget? afterMainScreen;
  final Widget? floatingButton;
  final Function()? willPopup;
  final bool isScroll;
  const CustomTemplateScreenStackScroll({
    super.key,
    required this.children,
    required this.appBar,
    this.paddingAll,
    this.paddingView,
    this.color,
    this.bottomSheet,
    this.willPopup,
    this.afterMainScreen,
    this.floatingButton,
    this.isScroll = true,
  });

  @override
  State<CustomTemplateScreenStackScroll> createState() =>
      _CustomTemplateScreenStackScrollState();
}

class _CustomTemplateScreenStackScrollState
    extends State<CustomTemplateScreenStackScroll> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.willPopup != null) {
          widget.willPopup!();
          return true;
        }
        return false;
      },
      child: Scaffold(
        extendBody: true,
        floatingActionButton: widget.floatingButton,
        bottomNavigationBar: widget.bottomSheet,
        backgroundColor:
            widget.color ?? Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            if (widget.afterMainScreen != null) widget.afterMainScreen!,
            CustomScrollView(
              physics: BouncingScrollPhysics(
                parent: widget.isScroll
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                if (widget.appBar != null) widget.appBar!,
                ...widget.children.map((e) => e)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
