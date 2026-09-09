import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

AppBar buildCustomAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.menu, color: AppColors.primaryColor),
      onPressed: () {
        // menu tap
      },
    ),
    title: Text(
      t.doctors,
      style: context.bold18Primary.copyWith(color: AppColors.titleColor),
    ),
    actions: [
      IconButton(
        icon: Stack(
          children: [
            const Icon(
              Icons.notifications_none_outlined,
              color: AppColors.inactiveIconColor,
              size: 26,
            ),
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          // Handle notifications tap
        },
      ),
      const SizedBox(width: 4),
      // User Avatar Circle
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primaryColor,
          child: Text('A', style: context.bold14White),
        ),
      ),
    ],
  );
}
