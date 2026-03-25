import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true; // Password visibility toggle ke liye

  @override
  Widget build(BuildContext context) {
    // Theme check: Light hai ya Dark?
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      
      // Text color according to theme
      style: TextStyle(
        fontSize: 14.sp,
        color: isDark ? AppColors.textDark : AppColors.textLight,
      ),

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: isDark ? AppColors.greyDark : AppColors.greyLight, 
          fontSize: 14.sp
        ),
        
        prefixIcon: widget.prefixIcon != null 
            ? Icon(widget.prefixIcon, color: AppColors.primary, size: 20.sp) 
            : null,
            
        // Password toggle logic (Interviewer isay pasand karega)
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : null,

        filled: true,
        // Dynamic Fill Color
        fillColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: isDark ? Colors.white10 : Colors.black12, 
            width: 1
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
      ),
    );
  }
}