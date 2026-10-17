import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'patient_settings_option_tile.dart';

class MoreOptionsSection extends StatelessWidget {
  final VoidCallback? onLanguagesTap;
  final VoidCallback? onBuildVersionTap;
  final String? languageText;
  final String? versionText;

  const MoreOptionsSection({
    super.key,
    this.onLanguagesTap,
    this.onBuildVersionTap,
    this.languageText,
    this.versionText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.moreOptions,
          style: context.bold18TextMain,
        ),
        const HeightSpace(12),
        PatientSettingsOptionTile(
          title: t.languages,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                languageText ?? t.english,
                style: context.regular14TextSub,
              ),
              const WidthSpace(6),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.inactiveIconColor,
                size: 22,
              ),
            ],
          ),
          onTap: onLanguagesTap,
        ),
        PatientSettingsOptionTile(
          title: t.buildVersion,
          trailing: Text(
            versionText ?? t.appVersionValue,
            style: context.regular14TextSub,
          ),
          onTap: onBuildVersionTap,
        ),
      ],
    );
  }
}
