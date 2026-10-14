import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'admin_settings_option_tile.dart';

class AdminSettingsOptionsCard extends StatelessWidget {
  final VoidCallback? onAdminProfileTap;
  final VoidCallback? onChangePasswordTap;
  final VoidCallback? onAppInformationTap;
  final String? versionText;

  const AdminSettingsOptionsCard({
    super.key,
    this.onAdminProfileTap,
    this.onChangePasswordTap,
    this.onAppInformationTap,
    this.versionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AdminSettingsOptionTile(
            icon: Icons.manage_accounts_outlined,
            title: t.adminProfile,
            subtitle: t.editSuperAdminDetails,
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.titleColor,
              size: 24,
            ),
            onTap: onAdminProfileTap,
          ),
          const Divider(
            color: AppColors.inactiveBorderColor,
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          AdminSettingsOptionTile(
            icon: Icons.lock_reset_rounded,
            title: t.changePassword,
            subtitle: t.updateMasterSecurityCredentials,
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.titleColor,
              size: 24,
            ),
            onTap: onChangePasswordTap,
          ),
          const Divider(
            color: AppColors.inactiveBorderColor,
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          AdminSettingsOptionTile(
            icon: Icons.info_outline_rounded,
            title: t.appInformation,
            subtitle: t.buildVersion,
            trailing: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Text(
                versionText ?? t.appVersionValue,
                style: context.regular14TextSub,
              ),
            ),
            onTap: onAppInformationTap,
          ),
        ],
      ),
    );
  }
}
