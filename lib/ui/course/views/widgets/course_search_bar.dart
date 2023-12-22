// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lettutor/core/utils/extensions/extensions.dart';

class CourseSearchBar extends StatefulWidget {
  const CourseSearchBar({
    Key? key,
    this.height,
    this.onSearch,
    required this.controller,
    this.hint = "",
    this.onTapFilter,
  }) : super(key: key);
  final double? height;
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

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: widget.controller,
              maxLines: 1,
              minLines: 1,
              onSubmitted: (value) {
                if (debounceTime != null) {
                  debounceTime?.cancel();
                  debounceTime = null;
                }
                debounceTime = Timer(const Duration(milliseconds: 200), () {
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
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                isDense: true,
                hintText: context.l10n.search,
                filled: true,
                iconColor: context.theme.hintColor,
                suffixIcon: ValueListenableBuilder(
                  valueListenable: widget.controller,
                  builder: (context, value, child) => value.text.isEmpty
                      ? const SizedBox()
                      : IconButton(
                          splashRadius: 15,
                          onPressed: () {
                            widget.controller.clear();
                            focusNode.requestFocus();
                          },
                          icon: Icon(
                            Icons.close,
                            color: context.theme.hintColor,
                          ),
                        ),
                ),
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
          ElevatedButton(
            onPressed: widget.onTapFilter,
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromWidth(widget.height ?? 35),
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
        ],
      ),
    );
  }
}
