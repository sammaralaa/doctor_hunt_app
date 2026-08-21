import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsCardWidget extends StatefulWidget {
  final VoidCallback? onBookNowPressed;

  const DoctorDetailsCardWidget({super.key, this.onBookNowPressed});
  @override
  State<DoctorDetailsCardWidget> createState() => _DoctorDetailsCardWidgetState();
}

class _DoctorDetailsCardWidgetState extends State<DoctorDetailsCardWidget> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1️⃣ الجزء العلوي: الصورة والمعلومات والقلب
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الطبيب
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  ImageAssets.doctorImage2, // استبدلي بـ Asset الصورة الخاصة بكِ
                  width: 84.w,
                  height: 84.h,
                  fit: BoxFit.cover,
                ),
              ),
              WidthSpace(12),

              // التفاصيل الوسطى (الاسم، التخصص، النجوم، السعر)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الاسم + زر المفضلة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Dr. Pediatrician',
                            style: AppTextStyles.buttonTextStyle.copyWith(
                              color: AppColors.titleColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: isFavorite ? Colors.red : const Color(0xFF677294),
                            size: 20.r,
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(4),

                    // التخصص
                    Text(
                      'Specialist Cardiologist',
                      style: AppTextStyles.subTitleTextStyle.copyWith(
                        fontSize: 12.sp,
                        color: const Color(0xFF677294),
                      ),
                    ),
                    HeightSpace(8),

                    // النجوم والسعر
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // التقييم (4 نجوم ملونة ونجمة رمادية)
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star_rounded,
                              color: index < 4
                                  ? const Color(0xFFFFE600)
                                  : const Color(0xFFE2E5ED),
                              size: 14.r,
                            );
                          }),
                        ),

                        // السعر
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$ ',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                ),
                              ),
                              TextSpan(
                                text: '28.00/hr',
                                style: TextStyle(
                                  color: const Color(0xFF677294),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          HeightSpace(12),

          // 2️⃣ زر Book Now
          SizedBox(
            width: 140.w, // أو double.infinity لو حسّيتي محتاجة يملأ العرض
            height: 34.h,
            child: ElevatedButton(
              onPressed: widget.onBookNowPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // اللون الأخضر الخاص بالتطبيق
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                'Book Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}