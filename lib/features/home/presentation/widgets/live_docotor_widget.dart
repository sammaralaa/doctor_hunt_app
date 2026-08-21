import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveDocotorWidget extends StatelessWidget {
  const LiveDocotorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 168.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        // image: DecorationImage(
        //   image: AssetImage(ImageAssets.doctorImage),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                //color: Colors.black.withOpacity(0.15),
                image: DecorationImage(
                  image: AssetImage(ImageAssets.doctorImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned(
            top: 8.h,
            right: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFF0037),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 5.r,
                    height: 5.r,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 22.r,
            ),
          ),
        ],
      ),
    );
  }
}
