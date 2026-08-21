import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../../generated/app_text_styles.dart';

class CustomElevatdButton extends StatelessWidget{
  final String buttonTXT;
  final VoidCallback? onTap;

  const CustomElevatdButton({super.key, required this.buttonTXT,this.onTap});
  @override
  Widget build(BuildContext context) {
    return                   SizedBox(
      height: 50.h,
      width: 295.w,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10.r),
          ),
        ),
        child: Text(
          buttonTXT,
          style: AppTextStyles.buttonTextStyle,
        ),
      ),
    );
  }

}