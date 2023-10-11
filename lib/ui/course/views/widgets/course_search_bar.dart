import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class CourseSearchBar extends StatelessWidget {
  const CourseSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.green,
            ),
          ),
        ),
        IconButton(
          style:
              IconButton.styleFrom(backgroundColor: context.theme.primaryColor),
          onPressed: () {},
          icon: Icon(Icons.filter_list_outlined),
        ),
      ],
    );
  }
}
