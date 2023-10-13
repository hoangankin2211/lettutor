import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class CourseSearchBar extends StatelessWidget {
  const CourseSearchBar({
    super.key,
    required this.controller,
    this.hint = "",
  });

  final TextEditingController controller;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            maxLines: 1,
            minLines: 1,
            decoration: InputDecoration(
              isDense: true,
              hintText: "Search",
              filled: true,
              iconColor: context.theme.hintColor,
              prefixIcon: const Icon(CupertinoIcons.search),
              enabled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide.none,
              ),
              fillColor: context.theme.hintColor.withOpacity(0.08),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IntrinsicHeight(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              backgroundColor: context.theme.hintColor.withOpacity(0.08),
            ),
            child: Icon(
              Icons.filter_list_outlined,
              color: context.theme.hintColor,
            ),
          ),
        ),
      ],
    );
  }
}
