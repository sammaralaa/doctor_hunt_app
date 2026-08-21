import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularDoctorCardWidget extends StatelessWidget {
  const PopularDoctorCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () {
          // Handle card tap
          DoctorDetailsRoute().push(context);
        },
        child: Column(
          children: [
            Image.asset(
              ImageAssets.doctorImage2,
              // width: 120.w,
              // height: 120.h,
              fit: BoxFit.cover,
            ),
            HeightSpace(14),
            Text(
              'Dr. Fillerup Grab',
              style: AppTextStyles.buttonTextStyle.copyWith(
                color: AppColors.titleColor,
              ),
            ),
            Text('Medicine Specialist', style: AppTextStyles.subTitleTextStyle),
            HeightSpace(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star_rounded,
                  color: index < 4
                      ? const Color(0xFFFFE600) // لون النجمة الذهبي
                      : const Color(0xFFE2E5ED), // لون النجمة الرمادي
                  size: 12.r,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
