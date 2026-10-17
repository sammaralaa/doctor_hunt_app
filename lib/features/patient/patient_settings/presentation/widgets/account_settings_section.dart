import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'patient_settings_option_tile.dart';

class AccountSettingsSection extends StatelessWidget {
  final VoidCallback? onChangePasswordTap;
  final bool notificationsEnabled;
  final ValueChanged<bool>? onNotificationsChanged;
  final VoidCallback? onPrivacyPolicyTap;

  const AccountSettingsSection({
    super.key,
    this.onChangePasswordTap,
    this.notificationsEnabled = true,
    this.onNotificationsChanged,
    this.onPrivacyPolicyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.accountSettings,
          style: context.bold18TextMain,
        ),
        const HeightSpace(12),
        PatientSettingsOptionTile(
          leading: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.categoryColorRedFrom,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_rounded,
              color: AppColors.white,
              size: 18,
            ),
          ),
          title: t.changePassword,
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.inactiveIconColor,
            size: 22,
          ),
          onTap: onChangePasswordTap,
        ),
        PatientSettingsOptionTile(
          leading: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_rounded,
              color: AppColors.white,
              size: 18,
            ),
          ),
          title: t.notifications,
          trailing: Switch(
            value: notificationsEnabled,
            onChanged: onNotificationsChanged,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.primaryColor,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.inactiveBorderColor,
          ),
          onTap: () {
            if (onNotificationsChanged != null) {
              onNotificationsChanged!(!notificationsEnabled);
            }
          },
        ),
        PatientSettingsOptionTile(
          leading: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.categoryColorOrangeFrom,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.people_alt_rounded,
              color: AppColors.white,
              size: 18,
            ),
          ),
          title: t.privacyPolicy,
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.inactiveIconColor,
            size: 22,
          ),
          onTap: onPrivacyPolicyTap,
        ),
      ],
    );
  }
}
