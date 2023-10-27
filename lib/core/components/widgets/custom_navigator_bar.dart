import 'package:flutter/material.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/ui/course/views/course_screen.dart';

class CustomNavigatorBar extends StatefulWidget {
  const CustomNavigatorBar({super.key, required this.tabs});

  final List<String> tabs;

  @override
  State<CustomNavigatorBar> createState() => _CustomNavigatorBarState();
}

class _CustomNavigatorBarState extends State<CustomNavigatorBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  late double currentPos = mapCoordinate[0]!.toDouble();

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    super.initState();
  }

  final mapCoordinate = {
    0: 25,
    1: 100,
    2: 200,
  };

  int currentIndex = 0;
  int previousIndex = 0;

  void animateTo(int index) {
    if (currentIndex != index) {
      setState(() {
        previousIndex = currentIndex;
        currentIndex = index;
      });
      animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)
        ],
        borderRadius: BorderRadius.circular(20),
        color: context.theme.cardColor,
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              currentPos = mapCoordinate[previousIndex]! +
                  animation.value * 130 * (currentIndex - previousIndex) +
                  5;
              return Transform.translate(
                offset: Offset(currentPos, 40),
                child: child,
              );
            },
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.theme.primaryColor,
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.tabs
                  .asMap()
                  .entries
                  .map(
                    (entries) => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => animateTo(entries.key),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Text(
                            entries.value,
                            style: context.textTheme.titleMedium?.boldTextTheme,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
