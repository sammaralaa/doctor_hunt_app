import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchTextFieldWidget extends StatefulWidget {
  final ValueChanged<String>? onSubmit;
  const CustomSearchTextFieldWidget({super.key, required this.onSubmit});
  @override
  State<StatefulWidget> createState() => _CustomSearchTextFieldWidget();
}

class _CustomSearchTextFieldWidget extends State<CustomSearchTextFieldWidget> {
  TextEditingController? get searchController => null;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onSubmitted: widget.onSubmit,
        decoration: InputDecoration(
          hintText: 'Search.....',
          hintStyle: AppTextStyles.subTitleTextStyle.copyWith(fontSize: 15.sp),
          prefixIcon: const Icon(Icons.search, color: AppColors.subtitleColor),
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
    );
  }
}
