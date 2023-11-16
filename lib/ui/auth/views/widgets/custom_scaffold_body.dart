import 'package:flutter/material.dart';
class CustomScaffoldBody extends StatelessWidget {
  final Widget child;
  const CustomScaffoldBody({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TCRoundContainer(
        child: child,
      ),
    );
  }
}

// ignore: must_be_immutable
class ScrollDismissKeyboard extends StatelessWidget {
  final Widget child;
  double _startDy = 0;
  ScrollDismissKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (t) {
        if (t is ScrollStartNotification) {
          if (t.dragDetails?.localPosition != null) {
            _startDy = t.dragDetails!.localPosition.dy;
          }
        }

        if (t is ScrollUpdateNotification) {
          if (t.dragDetails?.localPosition != null) {
            double delta = t.dragDetails!.localPosition.dy - _startDy;
            if (delta >= 30) {
              FocusScope.of(context).requestFocus(FocusNode());
            }
          }
        }

        return false;
      },
      child: child,
    );
  }
}

class TCRoundContainer extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  final double? height;

  const TCRoundContainer({
    super.key,
    required this.child,
    this.padding =
        const EdgeInsets.symmetric(horizontal: 20 * 1.5, vertical: 20),
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      padding: padding,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
