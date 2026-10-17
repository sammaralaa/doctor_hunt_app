import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/controller/admin_appointments_bloc.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/controller/admin_appointments_event.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/controller/admin_appointments_state.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/widgets/admin_appointment_dialogs.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/widgets/appointment_card_widget.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/widgets/admin_custom_app_bar.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class AdminAppointmentsScreen extends StatelessWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminAppointmentsBloc>()
        ..add(const LoadAdminAppointmentsEvent()),
      child: const AdminAppointmentsView(),
    );
  }
}

class AdminAppointmentsView extends StatelessWidget {
  const AdminAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: buildCustomAppBar(context, title: t.appointments),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Filter Tabs
          _buildFilterTabs(context),
          const SizedBox(height: 16),

          // List with BLoC consumer
          Expanded(
            child: BlocConsumer<AdminAppointmentsBloc, AdminAppointmentsState>(
              listenWhen: (previous, current) {
                if (previous is AdminAppointmentsLoadedState &&
                    current is AdminAppointmentsLoadedState) {
                  return current.successMessage != null &&
                          current.successMessage != previous.successMessage ||
                      current.errorMessage != null &&
                          current.errorMessage != previous.errorMessage;
                }
                return false;
              },
              listener: (context, state) {
                if (state is AdminAppointmentsLoadedState) {
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
                if (state is AdminAppointmentsLoadingState ||
                    state is AdminAppointmentsInitialState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                if (state is AdminAppointmentsErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          color: AppColors.red,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.errorMessage,
                          style: context.regular14TextSub,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<AdminAppointmentsBloc>().add(
                                  const LoadAdminAppointmentsEvent(),
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
                  );
                }

                if (state is AdminAppointmentsLoadedState) {
                  final appointments = state.appointments;

                  if (appointments.isEmpty) {
                    return Center(
                      child: Text(
                        t.noAppointmentsFound,
                        style: context.regular16TextSub,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = appointments[index];
                      return AppointmentCardWidget(
                        key: ValueKey(appointment.id),
                        appointment: appointment,
                        isOperating: state.isOperating(appointment.id),
                        onCancel: () {
                          showCancelAppointmentConfirmationDialog(
                            context: context,
                            onConfirm: () {
                              context.read<AdminAppointmentsBloc>().add(
                                    CancelAppointmentEvent(appointment.id),
                                  );
                            },
                          );
                        },
                        onMarkCompleted: () {
                          showCompleteAppointmentConfirmationDialog(
                            context: context,
                            onConfirm: () {
                              context.read<AdminAppointmentsBloc>().add(
                                    MarkAsCompletedEvent(appointment.id),
                                  );
                            },
                          );
                        },
                        onViewDetails: () {
                          AppointmentDetailsRoute(
                            appointmentId: appointment.id,
                          ).push(context);
                        },
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    return BlocBuilder<AdminAppointmentsBloc, AdminAppointmentsState>(
      builder: (context, state) {
        final selectedFilter = state is AdminAppointmentsLoadedState
            ? state.selectedFilter
            : AppointmentFilter.upcoming;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildTab(
                context,
                AppointmentFilter.upcoming,
                t.upcoming,
                selectedFilter,
              ),
              const SizedBox(width: 8),
              _buildTab(
                context,
                AppointmentFilter.completed,
                t.completed,
                selectedFilter,
              ),
              const SizedBox(width: 8),
              _buildTab(
                context,
                AppointmentFilter.cancelled,
                t.cancelled,
                selectedFilter,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(
    BuildContext context,
    AppointmentFilter filter,
    String title,
    AppointmentFilter selectedFilter,
  ) {
    final isSelected = filter == selectedFilter;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<AdminAppointmentsBloc>().add(ChangeFilterEvent(filter));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.mintBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: isSelected ? context.medium12White : context.medium12Primary,
          ),
        ),
      ),
    );
  }
}
