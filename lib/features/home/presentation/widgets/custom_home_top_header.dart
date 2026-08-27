import 'dart:ui';

import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeTopHeader extends StatelessWidget {
  final TextEditingController? searchController;

  const CustomHomeTopHeader({super.key, this.searchController});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi Handwerker!',
                    style: AppTextStyles.buttonTextStyle.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    t.findYourDoctor,
                    style: AppTextStyles.titleTextStyle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  HeightSpace(30),
                ],
              ),
              Image.asset(ImageAssets.onBoarding5, width: 60.w, height: 60.h),
            ],
          ),
        ),

        Positioned(
          left: 20.w,
          right: 20.w,
          bottom: -24.h,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha:0.06),
                  blurRadius: 15.r,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              onSubmitted: (value) => {FindDoctorsRoute().push(context)},
              decoration: InputDecoration(
                hintText: t.search,
                hintStyle: AppTextStyles.subTitleTextStyle.copyWith(
                  fontSize: 15.sp,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.subtitleColor,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.subtitleColor),
                  onPressed: () {
                    //searchController.clear();
                  },
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
