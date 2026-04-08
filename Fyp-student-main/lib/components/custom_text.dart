import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle = GoogleFonts.manrope(
  // fontSize: 14,
  color: Colors.black,
);

class CustomText extends StatefulWidget {
  final String title;
  final String? family;
  final FontWeight fontWeight;
  final double? size;
  final double? wordSpacing;
  final double? height;
  final Color? color;
  final TextOverflow? toverflow;
  final bool? center;
  final int? line;
  final bool? under, cut, softWrap;

  const CustomText({
    super.key,
    required this.title,
    this.size,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.family,
    this.center,
    this.line,
    this.under,
    this.toverflow,
    this.softWrap,
    this.cut,
    this.height,
    this.wordSpacing,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Text(
      widget.title,
      overflow: widget.toverflow ?? TextOverflow.visible,
      maxLines: widget.line,
      softWrap: widget.softWrap,
      style: TextStyle(
          height: widget.height ?? 1,
          // fontFamily: '$family',
          // fontFamily: 'TypesketchbookNoyhGeometricRegular',
          // style: GoogleFonts.signika(
          decoration: widget.under == true
              ? TextDecoration.underline
              : widget.cut == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
          fontFamily: widget.family ?? "Manrope",
          fontSize: widget.size,
          color: widget.color ?? theme.onBackground,
          wordSpacing: widget.wordSpacing,
          fontWeight: widget.fontWeight),
      textAlign: widget.center == null
          ? TextAlign.left
          : widget.center!
              ? TextAlign.center
              : TextAlign.left,
    );
  }
}