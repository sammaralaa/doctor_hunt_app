import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/services/shared_prefs_service.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_bloc.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_event.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_state.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/widgets/appointment_details_doctor_card.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/widgets/appointment_details_info_card.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/widgets/appointment_details_patient_card.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/widgets/cancel_appointment_dialog.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final String appointmentId;

  const AppointmentDetailsScreen({
    super.key,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    try {
      context.read<AppointmentDetailsBloc>();
      return AppointmentDetailsView(appointmentId: appointmentId);
    } catch (_) {
      return BlocProvider(
        create: (context) => getIt<AppointmentDetailsBloc>()
          ..add(FetchAppointmentDetailsEvent(appointmentId)),
        child: AppointmentDetailsView(appointmentId: appointmentId),
      );
    }
  }
}

class AppointmentDetailsView extends StatelessWidget {
  final String appointmentId;

  const AppointmentDetailsView({
    super.key,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    final userRole = SharedPrefsService.getUserRole()?.toLowerCase();
    final isAdmin = userRole == 'admin';

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const TopLeftShadowWidget(),
          const BottomRightShadowWidget(),
          SafeArea(
            child: BlocConsumer<AppointmentDetailsBloc, AppointmentDetailsState>(
              listener: (context, state) {
                if (state is AppointmentDetailsLoadedState) {
                  if (state.successMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.successMessage!),
                        backgroundColor: AppColors.primaryColor,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage!),
                        backgroundColor: AppColors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const HeightSpace(10),
                          CustomAppBarWidget(
                            showSearchIcon: false,
                            title: t.appointmentDetails,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _buildBody(context, state, isAdmin),
                    ),
                    if (state is AppointmentDetailsLoadedState)
                      _buildBottomButtons(context, state, isAdmin),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppointmentDetailsState state,
    bool isAdmin,
  ) {
    if (state is AppointmentDetailsLoadingState ||
        state is AppointmentDetailsInitialState) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
    }

    if (state is AppointmentDetailsErrorState) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.red,
                size: 44,
              ),
              const SizedBox(height: 12),
              Text(
                state.errorMessage,
                style: context.regular14TextSub,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<AppointmentDetailsBloc>().add(
                        FetchAppointmentDetailsEvent(appointmentId),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.refresh),
                label: Text(
                  t.retry,
                  style: context.medium12White,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state is AppointmentDetailsLoadedState) {
      final appointment = state.appointment;

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isAdmin) ...[
              AppointmentDetailsPatientCard(
                patientName: appointment.patientName,
                patientImage: appointment.patientImage,
                patientEmail: appointment.patientEmail,
              ),
              const SizedBox(height: 18),
            ],
            AppointmentDetailsDoctorCard(
              doctorName: appointment.doctorName,
              doctorSpecialty: appointment.doctorSpecialty,
              doctorImage: appointment.doctorImage,
            ),
            const SizedBox(height: 18),
            AppointmentDetailsInfoCard(
              date: appointment.date,
              time: appointment.time,
              fee: appointment.fee,
              status: appointment.status,
              clinicLocation: appointment.clinicLocation,
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildBottomButtons(
    BuildContext context,
    AppointmentDetailsLoadedState state,
    bool isAdmin,
  ) {
    final appointment = state.appointment;
    final status = appointment.status.toLowerCase().trim();
    final isUpcoming = status == 'upcoming';
    final isCancelled = status == 'cancelled' || status == 'canceled';
    final isCompleted = status == 'completed';

    final showCancelButton = isUpcoming;
    final showCompleteButton = isAdmin && isUpcoming;

    if (!showCancelButton && !showCompleteButton) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.titleColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: showCancelButton && showCompleteButton
            ? Row(
                children: [
                  Expanded(
                    child: _buildCancelButton(
                      context: context,
                      state: state,
                      isCancelled: isCancelled,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCompleteButton(
                      context: context,
                      state: state,
                      isCompleted: isCompleted,
                    ),
                  ),
                ],
              )
            : SizedBox(
                width: double.infinity,
                child: showCancelButton
                    ? _buildCancelButton(
                        context: context,
                        state: state,
                        isCancelled: isCancelled,
                      )
                    : _buildCompleteButton(
                        context: context,
                        state: state,
                        isCompleted: isCompleted,
                      ),
              ),
      ),
    );
  }

  Widget _buildCancelButton({
    required BuildContext context,
    required AppointmentDetailsLoadedState state,
    required bool isCancelled,
  }) {
    return GestureDetector(
      onTap: state.isProcessing || isCancelled
          ? null
          : () {
              final bloc = context.read<AppointmentDetailsBloc>();
              showCancelAppointmentDialog(
                context: context,
                onConfirm: () {
                  bloc.add(
                    CancelAppointmentDetailEvent(state.appointment.id),
                  );
                },
              );
            },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.red.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCancelled
                ? AppColors.inactiveBorderColor
                : AppColors.red.withValues(alpha: 0.4),
          ),
        ),
        alignment: Alignment.center,
        child: state.isProcessing
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.red,
                ),
              )
            : Text(
                t.cancelAppointment,
                style: context.semiBold14Danger.copyWith(
                  color: isCancelled
                      ? AppColors.inactiveIconColor
                      : AppColors.categoryColorRedFrom,
                ),
              ),
      ),
    );
  }

  Widget _buildCompleteButton({
    required BuildContext context,
    required AppointmentDetailsLoadedState state,
    required bool isCompleted,
  }) {
    return GestureDetector(
      onTap: state.isProcessing || isCompleted
          ? null
          : () {
              context.read<AppointmentDetailsBloc>().add(
                    MarkAppointmentCompletedDetailEvent(state.appointment.id),
                  );
            },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isCompleted
              ? AppColors.inactiveIconColor
              : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: state.isProcessing
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_rounded,
                    color: AppColors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    t.markAsCompleted,
                    style: context.semiBold14White,
                  ),
                ],
              ),
      ),
    );
  }
}
