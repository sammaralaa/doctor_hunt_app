import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/spacing_widgets.dart';

class RoleSelectionCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData roleIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleSelectionCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.roleIcon,
    required this.isSelected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    const activeBorderColor = AppColors.primaryColor;
    final activeBgColor = Color(0XFFD5E6E1).withAlpha(30);
    const inactiveBgColor = Color(0XFFFAFCFB);
    const inactiveBorderColor = AppColors.inactiveBorderColor;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? activeBgColor : inactiveBgColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? activeBorderColor : inactiveBorderColor,
            width: 2.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                size: 32,
                roleIcon,
                color: isSelected
                    ? activeBorderColor
                    : AppColors.inactiveIconColor,
              ),
              WidthSpace(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.bold20TextMain,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      description,
                      style: context.regular14TextSub,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
             if( isSelected)
               Icon(Icons.check_circle_rounded, color: AppColors.primaryColor,size: 25.w,),
            ],
          ),
        ),
      ),
    );
  }
}
