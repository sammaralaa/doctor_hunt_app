import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureDoctorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.favorite_border, color: AppColors.red, size: 10),
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.yellow, size: 10),
                  Text('4.5', style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
          HeightSpace(8),
          Image.asset(ImageAssets.onBoarding5, width: 55.w, height: 55.h),
          HeightSpace(10),
          Text(
            'Dr. Crick',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text(
            '25.00/ hours',
            style: TextStyle(fontSize: 10, color: AppColors.subtitleColor),
          ),
        ],
      ),
    );
  }
}
