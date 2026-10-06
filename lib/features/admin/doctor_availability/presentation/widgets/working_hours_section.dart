import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/widgets/time_slot_picker_field.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class WorkingHoursSection extends StatelessWidget {
  final String startTime;
  final String endTime;
  final int slotDuration;
  final ValueChanged<String> onStartTimeChanged;
  final ValueChanged<String> onEndTimeChanged;
  final ValueChanged<int> onSlotDurationChanged;

  const WorkingHoursSection({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onSlotDurationChanged,
  });

  TimeOfDay _parseTime(String time24) {
    try {
      final parts = time24.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return const TimeOfDay(hour: 9, minute: 0);
    }
  }

  String _formatTo24(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatTo12(String time24) {
    final time = _parseTime(time24);
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  Future<void> _selectTime(
    BuildContext context, {
    required String currentTime,
    required ValueChanged<String> onSelected,
  }) async {
    final initial = _parseTime(currentTime);
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.white,
              onSurface: AppColors.titleColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onSelected(_formatTo24(picked));
    }
  }

  void _showSlotDurationBottomSheet(BuildContext context) {
    final durations = [15, 20, 30, 45, 60];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.inactiveBorderColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const HeightSpace(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    t.slotDuration,
                    style: context.bold16TextMain,
                  ),
                ),
                const HeightSpace(12),
                ...durations.map((duration) {
                  final isSelected = duration == slotDuration;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    leading: Icon(
                      Icons.timer_outlined,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.inactiveIconColor,
                    ),
                    title: Text(
                      t.minutes(count: duration.toString()),
                      style: isSelected
                          ? context.bold16Primary
                          : context.regular14TextMain,
                    ),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.primaryColor,
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(sheetContext);
                      onSlotDurationChanged(duration);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.workingHours,
          style: context.bold16TextMain,
        ),
        const HeightSpace(12),
        Container(
          padding: const EdgeInsets.all(16),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TimeSlotPickerField(
                      label: t.startTime,
                      value: _formatTo12(startTime),
                      icon: Icons.access_time_rounded,
                      onTap: () => _selectTime(
                        context,
                        currentTime: startTime,
                        onSelected: onStartTimeChanged,
                      ),
                    ),
                  ),
                  const WidthSpace(12),
                  Expanded(
                    child: TimeSlotPickerField(
                      label: t.endTime,
                      value: _formatTo12(endTime),
                      icon: Icons.access_time_rounded,
                      onTap: () => _selectTime(
                        context,
                        currentTime: endTime,
                        onSelected: onEndTimeChanged,
                      ),
                    ),
                  ),
                ],
              ),
              const HeightSpace(16),
              TimeSlotPickerField(
                label: t.slotDuration,
                value: t.minutes(count: slotDuration.toString()),
                icon: Icons.timer_outlined,
                onTap: () => _showSlotDurationBottomSheet(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
