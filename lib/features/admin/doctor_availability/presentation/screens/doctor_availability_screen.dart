import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/controller/doctor_availability_bloc.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/controller/doctor_availability_event.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/controller/doctor_availability_state.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/widgets/doctor_header_card.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/widgets/working_days_section.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/widgets/working_hours_section.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DoctorAvailabilityScreen extends StatefulWidget {
  final String doctorId;

  const DoctorAvailabilityScreen({super.key, required this.doctorId});

  @override
  State<DoctorAvailabilityScreen> createState() =>
      _DoctorAvailabilityScreenState();
}

class _DoctorAvailabilityScreenState extends State<DoctorAvailabilityScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorAvailabilityBloc>().add(
          FetchDoctorAvailabilityEvent(doctorId: widget.doctorId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.titleColor,
          ),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: Text(
          t.doctorAvailability,
          style: context.bold20TextMain,
        ),
      ),
      body: BlocConsumer<DoctorAvailabilityBloc, DoctorAvailabilityState>(
        listener: (context, state) {
          if (state is DoctorAvailabilityLoadedState) {
            if (state.saveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.availabilitySavedSuccessfully),
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
          } else if (state is DoctorAvailabilityFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: AppColors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DoctorAvailabilityLoadingState ||
              state is DoctorAvailabilityInitialState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is DoctorAvailabilityFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage,
                    style: context.regular14TextSub,
                    textAlign: TextAlign.center,
                  ),
                  const HeightSpace(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DoctorAvailabilityBloc>().add(
                            FetchDoctorAvailabilityEvent(
                              doctorId: widget.doctorId,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: Text(t.retry, style: context.bold14White),
                  ),
                ],
              ),
            );
          } else if (state is DoctorAvailabilityLoadedState) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorHeaderCard(doctor: state.doctor),
                    const HeightSpace(20),
                    WorkingDaysSection(
                      workingDays: state.availability.workingDays,
                      onToggleDay: (dayIndex) {
                        context.read<DoctorAvailabilityBloc>().add(
                              ToggleWorkingDayEvent(dayIndex: dayIndex),
                            );
                      },
                    ),
                    const HeightSpace(20),
                    WorkingHoursSection(
                      startTime: state.availability.startTime,
                      endTime: state.availability.endTime,
                      slotDuration: state.availability.slotDuration,
                      onStartTimeChanged: (time) {
                        context.read<DoctorAvailabilityBloc>().add(
                              ChangeStartTimeEvent(startTime: time),
                            );
                      },
                      onEndTimeChanged: (time) {
                        context.read<DoctorAvailabilityBloc>().add(
                              ChangeEndTimeEvent(endTime: time),
                            );
                      },
                      onSlotDurationChanged: (duration) {
                        context.read<DoctorAvailabilityBloc>().add(
                              ChangeSlotDurationEvent(
                                slotDuration: duration,
                              ),
                            );
                      },
                    ),
                    const HeightSpace(24),
                    CustomElevatdButton(
                      buttonWidth: double.infinity,
                      onTap: state.isSaving
                          ? null
                          : () {
                              context.read<DoctorAvailabilityBloc>().add(
                                    const SaveDoctorAvailabilityEvent(),
                                  );
                            },
                      childWidget: state.isSaving
                          ? const Center(
                              child: SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2.5,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: AppColors.white,
                                  size: 20,
                                ),
                                const WidthSpace(8),
                                Text(
                                  t.saveAvailability,
                                  style: context.bold16White,
                                ),
                              ],
                            ),
                    ),
                    const HeightSpace(20),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
