import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt_app/core/models/appointment_model.dart';
import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_bloc.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_event.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_state.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/widgets/cancel_appointment_dialog.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/widgets/patient_appointment_card_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class PatientAppointmentsScreen extends StatelessWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PatientAppointmentsBloc>()
        ..add(const FetchPatientAppointmentsEvent()),
      child: const PatientAppointmentsView(),
    );
  }
}

class PatientAppointmentsView extends StatefulWidget {
  const PatientAppointmentsView({super.key});

  @override
  State<PatientAppointmentsView> createState() =>
      _PatientAppointmentsViewState();
}

class _PatientAppointmentsViewState extends State<PatientAppointmentsView> {
  PatientAppointmentStatus _selectedFilter = PatientAppointmentStatus.upcoming;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const TopLeftShadowWidget(),
          const BottomRightShadowWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const HeightSpace(10),
                  CustomAppBarWidget(
                    showSearchIcon: false,
                    title: t.appointments,
                  ),
                  const HeightSpace(20),
                  _buildFilterTabs(),
                  const HeightSpace(20),
                  Expanded(
                    child: BlocConsumer<PatientAppointmentsBloc,
                        PatientAppointmentsState>(
                      listenWhen: (previous, current) {
                        if (previous is PatientAppointmentsLoadedState &&
                            current is PatientAppointmentsLoadedState) {
                          return (current.cancelSuccess &&
                                  !previous.cancelSuccess) ||
                              (current.cancelErrorMessage != null &&
                                  current.cancelErrorMessage !=
                                      previous.cancelErrorMessage);
                        }
                        return false;
                      },
                      listener: (context, state) {
                        if (state is PatientAppointmentsLoadedState) {
                          if (state.cancelSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(t.appointmentCancelledSuccessfully),
                                backgroundColor: AppColors.primaryColor,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else if (state.cancelErrorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.cancelErrorMessage!),
                                backgroundColor: AppColors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is PatientAppointmentsLoadingState ||
                            state is PatientAppointmentsInitialState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          );
                        }

                        if (state is PatientAppointmentsErrorState) {
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
                                    context.read<PatientAppointmentsBloc>().add(
                                          const FetchPatientAppointmentsEvent(),
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

                        if (state is PatientAppointmentsLoadedState) {
                          final currentList = _getListForFilter(state);

                          if (currentList.isEmpty) {
                            return Center(
                              child: Text(
                                t.noAppointmentsFound,
                                style: context.regular14TextSub,
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: currentList.length,
                            itemBuilder: (context, index) {
                              final appointment = currentList[index];
                              return PatientAppointmentCardWidget.fromModel(
                                key: ValueKey(appointment.id),
                                appointment: appointment,
                                isCancelling: state.isCancelling(appointment.id),
                                onViewDetails: () {
                                  AppointmentDetailsRoute(
                                    appointmentId: appointment.id,
                                  ).push(context);
                                },
                                onCancelAppointment: () {
                                  _showCancelConfirmationDialog(
                                    context,
                                    appointmentId: appointment.id,
                                  );
                                },
                                onRateDoctor: () {
                                  // Can trigger rate flow or dialog
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
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelConfirmationDialog(
    BuildContext context, {
    required String appointmentId,
  }) {
    final bloc = context.read<PatientAppointmentsBloc>();
    showCancelAppointmentDialog(
      context: context,
      onConfirm: () {
        bloc.add(CancelAppointmentEvent(appointmentId));
      },
    );
  }

  Widget _buildFilterTabs() {
    return Row(
      children: [
        _buildTab(
          status: PatientAppointmentStatus.upcoming,
          title: t.upcoming,
        ),
        const SizedBox(width: 8),
        _buildTab(
          status: PatientAppointmentStatus.completed,
          title: t.completed,
        ),
        const SizedBox(width: 8),
        _buildTab(
          status: PatientAppointmentStatus.cancelled,
          title: t.cancelled,
        ),
      ],
    );
  }

  Widget _buildTab({
    required PatientAppointmentStatus status,
    required String title,
  }) {
    final isSelected = _selectedFilter == status;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = status;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
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

  List<AppointmentModel> _getListForFilter(
    PatientAppointmentsLoadedState state,
  ) {
    switch (_selectedFilter) {
      case PatientAppointmentStatus.upcoming:
        return state.upcomingAppointments;
      case PatientAppointmentStatus.completed:
        return state.completedAppointments;
      case PatientAppointmentStatus.cancelled:
        return state.cancelledAppointments;
    }
  }
}
