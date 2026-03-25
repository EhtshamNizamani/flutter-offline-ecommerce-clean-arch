import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

enum AppFont { roboto, inter }

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final AppFont fontFamily;

  const CustomText(
    this.text, { // Normal text as first positional param
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.maxLines,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.fontFamily = AppFont.inter,
  });

  @override
  Widget build(BuildContext context) {
    // Theme se default text color uthayega
    final themeColor = Theme.of(context).brightness == Brightness.light
        ? AppColors.textLight
        : AppColors.textDark;

    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: fontSize?.sp ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? themeColor, // Use theme color if null
      ),
    );
  }
}
