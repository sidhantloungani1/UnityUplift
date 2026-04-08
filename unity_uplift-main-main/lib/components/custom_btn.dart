import 'package:flutter/material.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? height;
  final double? width;
  final Function()? onPressed;
  final Color? textColor;
  final bool isDoubleWidget;
  final Widget? widget;
  const CustomBtn(
      {Key? key,
      this.text,
      this.color,
      required this.onPressed,
      this.height,
      this.width,
      this.textColor,
      this.isDoubleWidget = false,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(10), // Set the border radius as needed
      child: MaterialButton(
        onPressed: onPressed,
        textColor: color ?? AppColors.secondaryColor,
        color: color ?? AppColors.primaryColor,
        height: height ?? 55,
        minWidth: width ?? 250,
        child: isDoubleWidget
            ? widget
            : Text(
                text ?? '',
                style: TextStyle(color: textColor, fontSize: 18),
              ),
      ),
    );
  }
}
