import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconBottomNav extends StatelessWidget {
  final String icon;
  final bool isSelected;

  CustomIconBottomNav({required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center( 
        child: SvgPicture.asset(
          icon,
          width: 20.w, 
          height: 20.h,
          fit: BoxFit.contain, 
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.white : AppColors.inactiveIconColor,
            BlendMode.srcIn,
          ),
        ),
      //  Icon(
      //   icon,
      //   color: isSelected ? AppColors.white : AppColors.inactiveIconColor,
      // ),
    ));
  }
}
