import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarWidget extends StatelessWidget {
  final bool showSearchIcon;
  final String title;
  const CustomAppBarWidget({
    super.key,
    required this.showSearchIcon,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            height: 30.h,
            width: 30.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 12.r,
              color: AppColors.subtitleColor,
            ),
          ),
        ),
        WidthSpace(10),
        Text(title, style: context.bold18TextMain),
        Spacer(),
        if (showSearchIcon)
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.subtitleColor,
              size: 20.r,
            ),
          ),
      ],
    );
  }
}
