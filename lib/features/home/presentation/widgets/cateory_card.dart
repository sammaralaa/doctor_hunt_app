import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // إذا كانت الأيقونة SVG

class CategoryCard extends StatelessWidget {
  final String iconPath; // أو IconData لو بتستخدمي Icons عادية
  final VoidCallback? onTap;
  final Color? fromColor;
  final Color? toColor;
  const CategoryCard({
    super.key,
    required this.iconPath,
    this.onTap,
    this.fromColor,
    this.toColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              fromColor ?? const Color(0xFF765AFC),
              toColor ?? const Color(0xFF765AFC),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color:
                  fromColor?.withOpacity(0.25) ??
                  const Color(0xFF765AFC).withOpacity(0.25),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 36.r,
            height: 36.r,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
