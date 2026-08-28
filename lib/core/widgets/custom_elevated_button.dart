import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

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
          style: context.bold18White,
        ),
      ),
    );
  }

}