import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class PatientSettingsOptionTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  const PatientSettingsOptionTile({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    const WidthSpace(16),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: context.regular16TextSub,
                    ),
                  ),
                  ?trailing,
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: AppColors.inactiveBorderColor.withValues(alpha: 0.6),
            height: 1,
            thickness: 1,
          ),
      ],
    );
  }
}
