import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class DayToggleRow extends StatelessWidget {
  final String dayName;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  const DayToggleRow({
    super.key,
    required this.dayName,
    required this.isEnabled,
    required this.onChanged,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isEnabled
                      ? AppColors.primaryColor.withValues(alpha: 0.1)
                      : AppColors.inactiveBorderColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: isEnabled
                      ? AppColors.primaryColor
                      : AppColors.inactiveIconColor,
                  size: 20,
                ),
              ),
              const WidthSpace(14),
              Text(
                dayName,
                style: isEnabled
                    ? context.semiBold14TextMain
                    : context.regular14TextSub,
              ),
              const Spacer(),
              Switch(
                value: isEnabled,
                onChanged: onChanged,
                activeThumbColor: AppColors.white,
                activeTrackColor: AppColors.primaryColor,
                inactiveThumbColor: AppColors.white,
                inactiveTrackColor: AppColors.inactiveBorderColor,
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.inactiveBorderColor.withValues(alpha: 0.6),
          ),
      ],
    );
  }
}
