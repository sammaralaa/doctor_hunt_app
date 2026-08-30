import 'dart:ui';

import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

class TopLeftShadowWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -108, // Half of height (216 / 2) to center on corner
      left: -108,  // Half of width (216 / 2)
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: 121, // Figma Blur: 121
          sigmaY: 121,
        ),
        child: Container(
          width: 216,
          height: 216,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor.withValues(alpha:0.30), // #0EBE7E @ 30%
          ),
        ),
      ),
    );
  }
}