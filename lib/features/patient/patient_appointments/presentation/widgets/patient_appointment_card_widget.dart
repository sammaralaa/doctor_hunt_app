import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_bloc.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_event.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/widgets/cancel_appointment_dialog.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

enum PatientAppointmentStatus {
  upcoming,
  completed,
  cancelled,
}

class PatientAppointmentCardWidget extends StatefulWidget {
  final String? appointmentId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImage;
  final String date;
  final String time;
  final String fee;
  final PatientAppointmentStatus status;
  final int initialRating;
  final bool isCancelling;
  final ValueChanged<int>? onRatingChanged;
  final VoidCallback? onViewDetails;
  final VoidCallback? onCancelAppointment;
  final VoidCallback? onRateDoctor;

  const PatientAppointmentCardWidget({
    super.key,
    this.appointmentId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImage,
    required this.date,
    required this.time,
    required this.fee,
    required this.status,
    this.initialRating = 0,
    this.isCancelling = false,
    this.onRatingChanged,
    this.onViewDetails,
    this.onCancelAppointment,
    this.onRateDoctor,
  });

  factory PatientAppointmentCardWidget.fromModel({
    Key? key,
    required AppointmentModel appointment,
    bool isCancelling = false,
    VoidCallback? onViewDetails,
    VoidCallback? onCancelAppointment,
    VoidCallback? onRateDoctor,
    ValueChanged<int>? onRatingChanged,
  }) {
    PatientAppointmentStatus status;
    final s = appointment.status.toLowerCase().trim();
    if (s == 'completed') {
      status = PatientAppointmentStatus.completed;
    } else if (s == 'cancelled' || s == 'canceled') {
      status = PatientAppointmentStatus.cancelled;
    } else {
      status = PatientAppointmentStatus.upcoming;
    }

    return PatientAppointmentCardWidget(
      key: key,
      appointmentId: appointment.id,
      doctorName: appointment.doctorName,
      doctorSpecialty: appointment.doctorSpecialty,
      doctorImage: appointment.doctorImage ?? '',
      date: appointment.date,
      time: appointment.time,
      fee: '\$${appointment.fee}',
      status: status,
      initialRating: appointment.rating?.toInt() ?? 0,
      isCancelling: isCancelling,
      onViewDetails: onViewDetails,
      onCancelAppointment: onCancelAppointment,
      onRateDoctor: onRateDoctor,
      onRatingChanged: onRatingChanged,
    );
  }

  @override
  State<PatientAppointmentCardWidget> createState() =>
      _PatientAppointmentCardWidgetState();
}

class _PatientAppointmentCardWidgetState
    extends State<PatientAppointmentCardWidget> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    final isCancelled = widget.status == PatientAppointmentStatus.cancelled;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.titleColor.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Doctor image, info, and status badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 52,
                  height: 52,
                  color: AppColors.mintBackground,
                  child: Image.network(
                    widget.doctorImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                      size: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctorName,
                      style: context.bold16Secondary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.doctorSpecialty,
                      style: context.regular12TextSub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        color: isCancelled
                            ? AppColors.red
                            : AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getStatusText(),
                      style: isCancelled
                          ? context.medium11Primary
                              .copyWith(color: AppColors.red)
                          : context.medium11Primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Appointment details (Date, Time, Fee)
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  icon: Icons.calendar_today_outlined,
                  label: t.appointmentDate,
                  value: widget.date,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoItem(
                  icon: Icons.access_time_rounded,
                  label: t.appointmentTime,
                  value: widget.time,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoItem(
                icon: Icons.attach_money_rounded,
                label: t.consultationFeeLabel,
                value: widget.fee,
              ),
            ],
          ),

          // Rating row (Only for Completed appointments)
          if (widget.status == PatientAppointmentStatus.completed) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  t.tapToRateYourVisit,
                  style: context.regular12TextSub,
                ),
                const Spacer(),
                Row(
                  children: List.generate(5, (index) {
                    final isFilled = index < _currentRating;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentRating = index + 1;
                        });
                        widget.onRatingChanged?.call(index + 1);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Icon(
                          isFilled
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: AppColors.yellow,
                          size: 20,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],

          const SizedBox(height: 16),

          // Dynamic Action Buttons based on status
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.mintBackground,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 14,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.regular11TextSub,
            ),
            Text(
              value,
              style: context.medium12Secondary,
            ),
          ],
        ),
      ],
    );
  }

  String _getStatusText() {
    switch (widget.status) {
      case PatientAppointmentStatus.upcoming:
        return t.upcoming;
      case PatientAppointmentStatus.completed:
        return t.completed;
      case PatientAppointmentStatus.cancelled:
        return t.cancelled;
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    switch (widget.status) {
      case PatientAppointmentStatus.upcoming:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onViewDetails,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                ),
                child: Text(
                  t.viewDetails,
                  style: context.medium12Primary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: widget.isCancelling
                    ? null
                    : () {
                        if (widget.onCancelAppointment != null) {
                          widget.onCancelAppointment!();
                        } else if (widget.appointmentId != null) {
                          final bloc = context.read<PatientAppointmentsBloc>();
                          showCancelAppointmentDialog(
                            context: context,
                            onConfirm: () {
                              bloc.add(
                                CancelAppointmentEvent(widget.appointmentId!),
                              );
                            },
                          );
                        }
                      },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppColors.red.withValues(alpha: 0.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                ),
                child: widget.isCancelling
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.red,
                        ),
                      )
                    : Text(
                        t.cancelAppointment,
                        style: context.medium12Primary
                            .copyWith(color: AppColors.red),
                      ),
              ),
            ),
          ],
        );

      case PatientAppointmentStatus.completed:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onViewDetails,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                ),
                child: Text(
                  t.viewDetails,
                  style: context.medium12Primary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onRateDoctor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                ),
                child: Text(
                  t.rateDoctor,
                  style: context.medium12White,
                ),
              ),
            ),
          ],
        );

      case PatientAppointmentStatus.cancelled:
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: widget.onViewDetails,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 11),
            ),
            child: Text(
              t.viewDetails,
              style: context.medium12Primary,
            ),
          ),
        );
    }
  }
}
