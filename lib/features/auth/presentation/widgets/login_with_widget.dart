import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/app_text_styles.dart';

class LoginWithWidget extends StatelessWidget{
  final String btnText;
  final VoidCallback onTop;
  final Widget btnIcon;

  const LoginWithWidget({super.key, required this.btnText, required this.onTop, required this.btnIcon});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:ElevatedButton.icon(
          onPressed: onTop,
          label: Text(btnText,style: AppTextStyles.loginWithButton,),
          icon: btnIcon,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            minimumSize: Size(0,54.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r), // Border radius
              side: const BorderSide(
                color: AppColors.white, // Light grey border color
                width: 1.0,               // Border thickness
              ),
            ),
          ),
        ));
  }
}