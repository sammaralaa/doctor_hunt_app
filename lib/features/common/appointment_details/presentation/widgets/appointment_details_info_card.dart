import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsInfoCard extends StatelessWidget {
  final String date;
  final String time;
  final num fee;
  final String status;
  final String? clinicLocation;

  const AppointmentDetailsInfoCard({
    super.key,
    required this.date,
    required this.time,
    required this.fee,
    required this.status,
    this.clinicLocation,
  });

  @override
  Widget build(BuildContext context) {
    final s = status.toLowerCase().trim();
    final isCancelled = s == 'cancelled' || s == 'canceled';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              t.appointment,
              style: context.bold16Secondary,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isCancelled
                    ? AppColors.red.withValues(alpha: 0.08)
                    : AppColors.mintBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isCancelled ? AppColors.red : AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    status,
                    style: isCancelled
                        ? context.medium11Primary.copyWith(color: AppColors.red)
                        : context.medium11Primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.titleColor.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildInfoBox(
                      context: context,
                      icon: Icons.calendar_today_outlined,
                      label: t.dateUpper,
                      value: date,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoBox(
                      context: context,
                      icon: Icons.access_time_rounded,
                      label: t.timeUpper,
                      value: time,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoBox(
                context: context,
                icon: Icons.attach_money_rounded,
                label: t.consultationFeeUpper,
                value: '\$${fee.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 12),
              _buildInfoBox(
                context: context,
                icon: Icons.location_on_outlined,
                label: t.clinicLocationUpper,
                value: clinicLocation ?? t.centralClinicAddress,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.mintBackground.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.mintBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.regular11TextSub.copyWith(
                    color: AppColors.inactiveIconColor,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: context.bold14TextMain,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
