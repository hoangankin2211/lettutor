import 'package:flutter/material.dart';
import 'package:lettutor/core/core.dart';

import '../../../../core/utils/widgets/app_loading_indicator.dart';

class TCInputField extends StatefulWidget {
  final bool ignoreShadow;
  final bool isLoading;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final FocusNode focusNode;
  final Widget? prefixIcon;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool filled;
  final Widget? clearTextIcon;
  final double? height;
  final EdgeInsets? scrollPadding;
  final String? errorText;
  final Color? fillColor;
  final double borderRadius;

  const TCInputField({
    super.key,
    required this.focusNode,
    this.hintText,
    this.labelText,
    this.helperText,
    this.keyboardType,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.textInputAction,
    this.onChanged,
    this.prefixIcon,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.clearTextIcon,
    this.height,
    this.fillColor,
    this.filled = true,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.borderRadius = 15,
    this.isLoading = false,
    this.ignoreShadow = false,
    this.errorText,
  });

  @override
  State<TCInputField> createState() => _TCInputFieldState();
}

class _TCInputFieldState extends State<TCInputField> {
  bool? obscureText;
  bool showClearText = false;
  String textValue = "";

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    widget.focusNode.addListener(_onFocus);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocus);
    super.dispose();
  }

  void _onFocus() {
    if (widget.focusNode.hasFocus) {
      setState(() {
        showClearText = widget.controller?.text.isNotEmpty ?? false;
      });
      return;
    }
    setState(() {
      showClearText = false;
    });
  }

  Widget? buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        splashRadius: 24,
        icon: Icon(
          obscureText! ? Icons.visibility_off : Icons.visibility,
          color: context.colorScheme.primary,
        ),
        onPressed: () {
          setState(() {
            obscureText = !obscureText!;
          });
        },
      );
    }

    var child = widget.isLoading ? [const AppLoadingIndicator()] : <Widget>[];

    if (showClearText) {
      child.add(
        IconButton(
          splashRadius: 24,
          icon: widget.clearTextIcon ?? Container(),
          color: context.theme.primaryTextTheme.bodyLarge?.color,
          onPressed: () {
            widget.controller!.text = '';
            if (widget.onChanged != null) {
              widget.onChanged!('');
            }
            setState(() {
              showClearText = false;
            });
          },
        ),
      );
    }
    if (child.length == 1) {
      return child.first;
    }
    if (child.isNotEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: child,
      );
    }

    return null;
  }

  Color? colorText() {
    return Colors.black;
  }

  Color? cursorColor() {
    return context.colorScheme.primary;
  }

  InputBorder? enableBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        borderSide: widget.ignoreShadow
            ? BorderSide(
                color: context.theme.dividerColor,
              )
            : BorderSide.none);
  }

  InputBorder? focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
      borderSide: BorderSide(
          color: context.colorScheme.primary,
          width: 1.0,
          style: BorderStyle.solid),
    );
  }

  InputBorder? normalBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(widget.borderRadius),
      ),
      borderSide: const BorderSide(
        color: Color(0XFFADADAD),
        width: 0.2,
      ),
    );
  }

  Widget buildTextFormField() {
    var child = TextFormField(
      style: context.textTheme.bodyMedium!.copyWith(
        color: colorText(),
      ),
      scrollPadding: widget.scrollPadding!,
      controller: widget.controller,
      obscureText: obscureText!,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: widget.focusNode,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      cursorColor: cursorColor(),
      onChanged: (text) {
        if (widget.onChanged != null) {
          widget.onChanged!(text);
        }
        setState(() {
          textValue = text;
          showClearText = text.isNotEmpty;
        });
      },
      decoration: InputDecoration(
        // enabledBorder: enableBorder(),
        // focusedBorder: focusedBorder(),
        fillColor: widget.fillColor,
        filled: widget.filled,
        border: normalBorder(),
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        hintStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.theme.primaryTextTheme.displayMedium?.color,
        ),
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: buildSuffixIcon(),
        errorText: widget.errorText,
        isDense: true,
      ),
    );

    return HRShadown(
      ignoreShadown: widget.ignoreShadow,
      radius: widget.borderRadius,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: widget.height ?? 56, child: buildTextFormField());
  }
}

class HRShadown extends StatelessWidget {
  final Widget child;
  final double radius;
  final bool ignoreShadown;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const HRShadown({
    Key? key,
    required this.child,
    this.radius = 10,
    this.ignoreShadown = false,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Container(
        padding: padding,
        color: backgroundColor,
        child: child,
      );
    }
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: backgroundColor,
        boxShadow: ignoreShadown
            ? []
            : [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.12),
                  blurRadius: 12,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
      ),
      child: child,
    );
  }
}
