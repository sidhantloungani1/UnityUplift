import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Color? color;
  final double? height;
  final double? width;
  final Function()? onPressed;
  final Color? textColor;
  final double? fontSize;
  const CustomBtn(
      {super.key,
      required this.text,
      this.color,
      required this.onPressed,
      this.height,
      this.width,
      this.textColor,
      this.fontSize,
      });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      textColor: color?? AppColors.secondaryColor,
      color: color ?? AppColors.primaryColor,
      height: height ?? 60,
      minWidth: width ?? 250,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: TextStyle(color: textColor,fontSize: fontSize ?? 18),),
    );
  }
}