import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/widgets/admin_custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import '../bloc/admin_appointments_bloc.dart';
import '../bloc/admin_appointments_event.dart';
import '../bloc/admin_appointments_state.dart';
import '../widgets/appointment_card_widget.dart';

class AdminAppointmentsScreen extends StatelessWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminAppointmentsBloc()..add(LoadAppointmentsEvent()),
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

          // List
          Expanded(
            child: BlocBuilder<AdminAppointmentsBloc, AdminAppointmentsState>(
              builder: (context, state) {
                if (state.appointments.isEmpty) {
                  return Center(
                    child: Text(
                      'No appointments found',
                      style: context.regular16TextSub,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = state.appointments[index];
                    return AppointmentCardWidget(
                      appointment: appointment,
                      onCancel: () {
                        // Handle cancel
                      },
                      onMarkCompleted: () {
                        // Handle complete
                      },
                      onViewDetails: () {
                        // Handle details
                      },
                    );
                  },
                );
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildTab(
                context,
                AppointmentFilter.upcoming,
                t.upcoming,
                state.selectedFilter,
              ),
              const SizedBox(width: 8),
              _buildTab(
                context,
                AppointmentFilter.completed,
                t.completed,
                state.selectedFilter,
              ),
              const SizedBox(width: 8),
              _buildTab(
                context,
                AppointmentFilter.cancelled,
                t.cancelled,
                state.selectedFilter,
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
