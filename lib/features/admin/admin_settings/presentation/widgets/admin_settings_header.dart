import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class AdminSettingsHeader extends StatelessWidget {
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;

  const AdminSettingsHeader({
    super.key,
    this.onNotificationPressed,
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          t.settings,
          style: context.bold24TextMain,
        ),
        const Spacer(),
        IconButton(
          onPressed: onNotificationPressed,
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.titleColor,
            size: 26,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const WidthSpace(14),
        GestureDetector(
          onTap: onProfilePressed,
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.white,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
