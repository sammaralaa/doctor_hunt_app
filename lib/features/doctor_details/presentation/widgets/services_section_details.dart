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
        // 1️⃣ عنوان "Services"
        Text(
          'Services',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.titleColor,
            fontFamily: 'Rubik',
          ),
        ),

        HeightSpace(16),

        // 2️⃣ القائمة المرقمة مع الخطوط الفاصلة
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: services.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(
              color: const Color(0xFFE8ECF2),
              thickness: 1.h,
              height: 1.h,
            ),
          ),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الرقم الأخضر بارز
                Text(
                  '${index + 1}.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor, // اللون الأخضر الأساسي للفرامورك
                    fontFamily: 'Rubik',
                  ),
                ),
                SizedBox(width: 10.w),
                // النص الخاص بالخدمة
                Expanded(
                  child: Text(
                    services[index],
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF677294),
                      height: 1.4,
                      fontFamily: 'Rubik',
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        HeightSpace(24),

        // 3️⃣ كارت الخريطة
        //const DoctorLocationMapWidget(),
      ],
    );
  }
}