import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';

class CourseSearchBar extends StatefulWidget {
  const CourseSearchBar({
    super.key,
    required this.controller,
    this.hint = "",
    this.onSearch,
    this.onTapFilter,
  });

  final void Function(String)? onSearch;
  final TextEditingController controller;
  final String hint;
  final VoidCallback? onTapFilter;

  @override
  State<CourseSearchBar> createState() => _CourseSearchBarState();
}

class _CourseSearchBarState extends State<CourseSearchBar> {
  Timer? debounceTime;

  @override
  void dispose() {
    debounceTime?.cancel();
    debounceTime = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            // onEditingComplete: () {
            //   logger.d(controller.text);
            //   if (onSearch != null && controller.text.isNotEmpty) {
            //     onSearch!(controller.text);
            //   }
            // },
            controller: widget.controller,
            maxLines: 1,
            minLines: 1,
            onSubmitted: (value) {
              if (debounceTime != null) {
                debounceTime?.cancel();
                debounceTime = null;
              }
              debounceTime = Timer(const Duration(seconds: 1), () {
                if (widget.onSearch != null) {
                  widget.onSearch!(value);
                }
              });
            },
            onChanged: (text) {
              if (debounceTime != null) {
                debounceTime?.cancel();
                debounceTime = null;
              }
              debounceTime = Timer(const Duration(seconds: 2), () {
                if (widget.onSearch != null) {
                  widget.onSearch!(text);
                }
              });
            },
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
              fillColor: context.theme.hintColor.withOpacity(0.1),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IntrinsicHeight(
          child: ElevatedButton(
            onPressed: widget.onTapFilter,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              backgroundColor: context.theme.hintColor.withOpacity(0.1),
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
