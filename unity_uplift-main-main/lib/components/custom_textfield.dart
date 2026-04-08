import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String text;
  final String? initialText;
  final Function(String value)? onChange;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? textInputType;
  final Function()? prefixIconTap;
  final bool? obsecureText;
  final bool? readOnly;
  final Color? borderColor;
  final double? borderSideWidth;
  final int? maxLines;
  final double? contentPadding;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputAction? textInputAction;
  final bool? autofocus;

  const CustomTextfield({
    Key? key,
    this.controller,
    this.validation,
    this.textInputType,
    this.prefixIconTap,
    required this.text,
    this.obsecureText,
    this.prefix,
    this.onChange,
    this.suffix,
    this.initialText,
    this.borderColor,
    this.borderSideWidth,
    this.maxLines,
    this.contentPadding,
    this.inputFormatter,
    this.textInputAction,
    this.readOnly,
    this.autofocus,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      autofocus: autofocus ?? false,
      inputFormatters: inputFormatter,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      readOnly: readOnly ?? false,
      validator: validation,
      onChanged: onChange,
      obscureText: obsecureText ?? false,
      initialValue: initialText,
      maxLines: maxLines ?? 1,
      cursorColor: theme.onPrimary,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.symmetric(
          // vertical: 18 ,
          vertical: contentPadding ?? 0,
          horizontal: 10,
        ),
        prefixIcon: prefix,
        suffixIcon: suffix,
        // suffix: suffix,
        // prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? theme.surface,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? theme.surface,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: borderColor ?? theme.surface, width: borderSideWidth ?? 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
