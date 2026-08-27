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
  State<DoctorDetailsCardWidget> createState() =>
      _DoctorDetailsCardWidgetState();
}

class _DoctorDetailsCardWidgetState extends State<DoctorDetailsCardWidget> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 15.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  ImageAssets.doctorImage2,
                  width: 84.w,
                  height: 84.h,
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
                            'Dr. Pediatrician',
                            style: AppTextStyles.buttonTextStyle.copyWith(
                              color: AppColors.titleColor,
                              fontSize: 16.sp,
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
                                ? AppColors.red
                                : AppColors.inactiveIconColor,
                            size: 20.r,
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(4),

                    Text(
                      'Specialist Cardiologist',
                      style: AppTextStyles.subTitleTextStyle.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    HeightSpace(8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star_rounded,
                              color: index < 4
                                  ? AppColors.yellow
                                  : AppColors.inactiveBorderColor,
                              size: 14.r,
                            );
                          }),
                        ),

                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$ ',
                                style: AppTextStyles.subTitleTextStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: '28.00/hr',
                                style: AppTextStyles.subTitleTextStyle.copyWith(
                                  fontSize: 16.sp,
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

          SizedBox(
            width: 140.w,
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
                style: AppTextStyles.buttonTextStyle.copyWith(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
