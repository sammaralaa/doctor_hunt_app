import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';

class DoctorSearchCardWidget extends StatefulWidget {
  final VoidCallback? onBookNowPressed;
  final VoidCallback? CardOnTap;

  const DoctorSearchCardWidget({
    super.key,
    this.onBookNowPressed,
    this.CardOnTap,
  });

  @override
  State<DoctorSearchCardWidget> createState() => _DoctorSearchCardWidgetState();
}

class _DoctorSearchCardWidgetState extends State<DoctorSearchCardWidget> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170.h,
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
      child: InkWell(
        onTap: widget.CardOnTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(14.r),
          child: Column(
            children: [
              // 1️⃣ القسم العلوي: الصورة + التفاصيل + القلب
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      ImageAssets.doctorImage2,
                      width: 88.w,
                      height: 88.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  WidthSpace(12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Dr. Shruti Kedia',
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
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: isFavorite
                                    ? Colors.red
                                    : const Color(0xFF677294),
                                size: 22.r,
                              ),
                            ),
                          ],
                        ),
                        HeightSpace(2),

                        // التخصص
                        Text(
                          'Tooths Dentist',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        HeightSpace(4),

                        // سنوات الخبرة
                        Text(
                          '7 Years experience',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF677294),
                          ),
                        ),
                        HeightSpace(8),

                        // النسبة المئوية وقصص المرضى (Patient Stories)
                        Row(
                          children: [
                            // النقطة الخضراء + النسبة
                            const CircleAvatar(
                              radius: 4,
                              backgroundColor: AppColors.primaryColor,
                            ),
                            WidthSpace(4),
                            Text(
                              '87%',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFF677294),
                              ),
                            ),
                            WidthSpace(14),

                            // النقطة الخضراء + عدد القصص
                            const CircleAvatar(
                              radius: 4,
                              backgroundColor: AppColors.primaryColor,
                            ),
                            WidthSpace(4),
                            Text(
                              '69 Patient Stories',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFF677294),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              HeightSpace(16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next Available',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      HeightSpace(2),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '10:00 ',
                              style: TextStyle(
                                color: AppColors.titleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            TextSpan(
                              text: 'AM tomorrow',
                              style: TextStyle(
                                color: const Color(0xFF677294),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: 110.w,
                    height: 34.h,
                    child: ElevatedButton(
                      onPressed: widget.onBookNowPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
