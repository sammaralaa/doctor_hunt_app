import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/widgets/day_toggle_row.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class WorkingDaysSection extends StatelessWidget {
  final List<int> workingDays;
  final ValueChanged<int> onToggleDay;

  const WorkingDaysSection({
    super.key,
    required this.workingDays,
    required this.onToggleDay,
  });

  String _getDaysCountText() {
    final count = workingDays.length;
    if (count == 0) {
      return t.noDaysEnabled;
    } else if (count == 1) {
      return t.oneDayEnabled;
    } else {
      return t.daysEnabled(count: count.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final daysList = [
      {'index': 1, 'name': t.monday},
      {'index': 2, 'name': t.tuesday},
      {'index': 3, 'name': t.wednesday},
      {'index': 4, 'name': t.thursday},
      {'index': 5, 'name': t.friday},
      {'index': 6, 'name': t.saturday},
      {'index': 7, 'name': t.sunday},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.workingDays,
              style: context.bold16TextMain,
            ),
            Text(
              _getDaysCountText(),
              style: context.regular12TextSub,
            ),
          ],
        ),
        const HeightSpace(12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: List.generate(daysList.length, (i) {
              final day = daysList[i];
              final dayIndex = day['index'] as int;
              final dayName = day['name'] as String;
              final isEnabled = workingDays.contains(dayIndex);
              final isLast = i == daysList.length - 1;

              return DayToggleRow(
                dayName: dayName,
                isEnabled: isEnabled,
                showDivider: !isLast,
                onChanged: (_) => onToggleDay(dayIndex),
              );
            }),
          ),
        ),
      ],
    );
  }
}
