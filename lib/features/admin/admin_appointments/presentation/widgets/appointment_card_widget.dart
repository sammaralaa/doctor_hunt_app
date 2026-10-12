import 'package:flutter/material.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import '../bloc/admin_appointments_state.dart';

class AppointmentCardWidget extends StatelessWidget {
  final MockAppointment appointment;
  final VoidCallback? onCancel;
  final VoidCallback? onMarkCompleted;
  final VoidCallback? onViewDetails;

  const AppointmentCardWidget({
    super.key,
    required this.appointment,
    this.onCancel,
    this.onMarkCompleted,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.mintBackground,
                  image: appointment.patientImage.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(appointment.patientImage),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: appointment.patientImage.isEmpty
                    ? const Icon(Icons.person, color: AppColors.primaryColor)
                    : null,
              ),
              const SizedBox(width: 12),
              // Name and Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.patientName,
                      style: context.bold16Secondary,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.doctorName,
                      style: context.regular12TextSub,
                    ),
                    Text(
                      appointment.doctorSpecialty,
                      style: context.regular12TextSub,
                    ),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: appointment.status == AppointmentFilter.cancelled
                      ? Colors.red.withValues(alpha: 0.1)
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
                        color: appointment.status == AppointmentFilter.cancelled
                            ? Colors.red
                            : AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getStatusText(),
                      style: context.medium11Primary.copyWith(
                        color: appointment.status == AppointmentFilter.cancelled
                            ? Colors.red
                            : AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.inactiveBorderColor, height: 1),
          const SizedBox(height: 16),

          // Details Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem(
                context,
                Icons.calendar_today_outlined,
                t.date,
                appointment.date,
              ),
              _buildDetailItem(
                context,
                Icons.access_time,
                t.time,
                appointment.time,
              ),
              _buildDetailItem(
                context,
                Icons.monetization_on_outlined,
                t.fee,
                appointment.fee,
              ),
            ],
          ),

          if (appointment.status == AppointmentFilter.completed &&
              appointment.rating != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${appointment.rating}',
                    style: context.medium12Secondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '- "${appointment.reviewText ?? ''}"',
                      style: context.regular12TextSub.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Action Buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: AppColors.mintBackground,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryColor, size: 14),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: context.regular11TextSub),
            Text(value, style: context.medium12Secondary),
          ],
        ),
      ],
    );
  }

  String _getStatusText() {
    switch (appointment.status) {
      case AppointmentFilter.upcoming:
        return t.upcoming;
      case AppointmentFilter.completed:
        return t.completed;
      case AppointmentFilter.cancelled:
        return t.cancelled;
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    if (appointment.status == AppointmentFilter.upcoming) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red.withOpacity(0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                t.cancelAppointment,
                style: context.medium12Secondary.copyWith(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: onMarkCompleted,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(t.markAsCompleted, style: context.medium12White),
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onViewDetails,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            side: const BorderSide(color: AppColors.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(t.viewDetails, style: context.medium12Primary),
        ),
      );
    }
  }
}
