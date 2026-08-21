import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberStatisticsWidget extends StatelessWidget {
  final String number;
  final String label;

  NumberStatisticsWidget({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.subtitleColor.withOpacity(0.1),
      ),
      child: Column(
        children: [
          Text(number, style: AppTextStyles.homeSectionsTitle),
          Text(label, style: AppTextStyles.subTitleTextStyle),
        ],
      ),
    );
  }
}
