import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';

class DoctorServicesSection extends StatelessWidget {
  final List<String> services;

  const DoctorServicesSection({
    super.key,
    this.services = const [
      'Patient care should be the number one priority.',
      'If you run your practice you know how frustrating.',
      'That’s why some of appointment reminder system.',
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Services', style: AppTextStyles.homeSectionsTitle),

        HeightSpace(16),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: services.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(
              color: AppColors.subtitleColor.withValues(alpha: 0.10),
              thickness: 1.h,
              height: 1.h,
            ),
          ),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}.',
                  style: AppTextStyles.rubik12bold.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    services[index],
                    style: AppTextStyles.subTitleTextStyle,
                  ),
                ),
              ],
            );
          },
        ),

        HeightSpace(24),
      ],
    );
  }
}
