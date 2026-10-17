import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class AppLogoutButton extends StatelessWidget {
  final VoidCallback? onLogoutPressed;

  const AppLogoutButton({
    super.key,
    this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onLogoutPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.logout_rounded,
                  color: AppColors.red,
                  size: 20,
                ),
                const WidthSpace(8),
                Text(
                  t.logout,
                  style: context.bold16Danger,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
