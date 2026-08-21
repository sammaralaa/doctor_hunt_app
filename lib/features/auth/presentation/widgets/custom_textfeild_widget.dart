import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class CustomTextfeildWidget extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool? isPassWord;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextfeildWidget({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderRadius,
    this.isPassWord,
    this.validator,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: height ?? 56.h,

      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPassWord ?? false,
        cursorColor: AppColors.primaryColor,

        decoration: InputDecoration(
          hintText: hintText ?? "",
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: Color(0xff8391A1),
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 18.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: const Color(0xffE8ECF4), width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          filled: true,
          fillColor: AppColors.white,
          suffixIcon: suffixIcon,

        ),
      ),
    );
  }
}