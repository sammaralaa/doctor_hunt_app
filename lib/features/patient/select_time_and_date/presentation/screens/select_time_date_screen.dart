import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/success_widget.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/data/date_slot_model.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_bloc.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_event.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_state.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/widgets/selected_doctor_info_card.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SelectTimeDateScreen extends StatefulWidget {
  final String doctorId;

  const SelectTimeDateScreen({super.key, required this.doctorId});

  @override
  State<StatefulWidget> createState() => _SelectTimeDateScreenState();
}

class _SelectTimeDateScreenState extends State<SelectTimeDateScreen> {
  String? _lastBookedDoctorName;
  String? _lastBookedDate;
  String? _lastBookedTime;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<SelectTimeDateBloc>();
    if (bloc.state is SelectTimeDateInitialState) {
      bloc.add(FetchDoctorAvailabilityEvent(widget.doctorId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: BlocConsumer<SelectTimeDateBloc, SelectTimeDateState>(
          listener: (context, state) {
            if (state is SelectTimeDateLoadedState) {
              if (state.bookingSuccess) {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) => SuccessWidget(
                    doctorName: _lastBookedDoctorName ?? state.doctor.name,
                    date: _lastBookedDate ??
                        DateFormat('MMMM d').format(state.selectedDate),
                    time: _lastBookedTime ?? '',
                  ),
                );
              } else if (state.errorMessage != null && !state.isBooking) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage!,
                      style: context.regular14.white,
                    ),
                    backgroundColor: AppColors.red,
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is SelectTimeDateLoadingState ||
                state is SelectTimeDateInitialState) {
              return Column(
                children: [
                  CustomAppBarWidget(
                    title: t.selectTime,
                    showSearchIcon: false,
                  ),
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is SelectTimeDateFailureState) {
              return Column(
                children: [
                  CustomAppBarWidget(
                    title: t.selectTime,
                    showSearchIcon: false,
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.errorMessage,
                            style: context.regular14TextSub,
                            textAlign: TextAlign.center,
                          ),
                          const HeightSpace(16),
                          CustomElevatdButton(
                            buttonTXT: t.retry,
                            onTap: () {
                              context.read<SelectTimeDateBloc>().add(
                                    FetchDoctorAvailabilityEvent(
                                      widget.doctorId,
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is! SelectTimeDateLoadedState) {
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                CustomAppBarWidget(
                  title: t.selectTime,
                  showSearchIcon: false,
                ),
                const HeightSpace(30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectedDoctorInfoCard(
                          name: state.doctor.name,
                          location: DoctorSpecialty.fromKey(
                            state.doctor.specialty,
                          ).displayName,
                          rating: 4,
                          imageUrl: state.doctor.profileImageUrl,
                          onBookNowPressed: () {},
                        ),
                        const HeightSpace(23),
                        _buildDaysSelector(context, state),
                        const HeightSpace(20),
                        if (state.isLoadingSlots)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        else if (!state.hasSlots)
                          _buildNoSlotsView(context)
                        else
                          _buildAvailableSlotsView(context, state),
                        if (state.selectedTimeSlot != null) ...[
                          const HeightSpace(24),
                          CustomElevatdButton(
                            buttonTXT: state.isBooking ? null : t.confirm,
                            childWidget: state.isBooking
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : null,
                            onTap: state.isBooking
                                ? null
                                : () {
                                    _lastBookedDoctorName = state.doctor.name;
                                    _lastBookedDate = DateFormat('MMMM d')
                                        .format(state.selectedDate);
                                    _lastBookedTime =
                                        state.selectedTimeSlot!.formattedTime;

                                    context.read<SelectTimeDateBloc>().add(
                                          BookAppointmentEvent(
                                            doctor: state.doctor,
                                            selectedDate: state.selectedDate,
                                            selectedTimeSlot:
                                                state.selectedTimeSlot!,
                                          ),
                                        );
                                  },
                            buttonWidth: double.infinity,
                          ),
                          const HeightSpace(20),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDaysSelector(
    BuildContext context,
    SelectTimeDateLoadedState state,
  ) {
    return SizedBox(
      height: 65,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.availableDays.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final day = state.availableDays[index];
          final isSelected = DateUtils.isSameDay(state.selectedDate, day);

          final dayModel = DaySlotModel(
            date: day,
            timeSlots: isSelected
                ? [
                    ...state.morningSlots,
                    ...state.afternoonSlots,
                    ...state.eveningSlots,
                  ]
                : const [],
          );

          final availabilityText = isSelected
              ? (state.hasSlots
                  ? t.slotsAvailable(count: state.totalAvailableSlotsCount)
                  : t.noSlotsAvailable)
              : ((state.doctor.availability?.workingDays
                          .contains(day.weekday) ??
                      true)
                  ? t.slots
                  : t.noSlotsAvailable);

          return InkWell(
            onTap: () {
              context.read<SelectTimeDateBloc>().add(SelectDateEvent(day));
            },
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.inactiveBorderColor,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayModel.dayLabel,
                    style: isSelected
                        ? context.regular16White
                        : context.regular16TextMain,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    availabilityText,
                    style: isSelected
                        ? context.regular8White
                        : context.regular8TextMain,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Slots Available
  Widget _buildAvailableSlotsView(
    BuildContext context,
    SelectTimeDateLoadedState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.morningSlots.isNotEmpty) ...[
          Text(
            t.morningSlots(length: state.morningSlots.length),
            style: context.bold14TextMain,
          ),
          const HeightSpace(12),
          _buildSlotsWrap(context, state.morningSlots, state.selectedTimeSlot),
          const HeightSpace(20),
        ],
        if (state.afternoonSlots.isNotEmpty) ...[
          Text(
            t.afternoonSlots(length: state.afternoonSlots.length),
            style: context.bold14TextMain,
          ),
          const HeightSpace(12),
          _buildSlotsWrap(
            context,
            state.afternoonSlots,
            state.selectedTimeSlot,
          ),
          const HeightSpace(20),
        ],
        if (state.eveningSlots.isNotEmpty) ...[
          Text(
            t.eveningSlots(length: state.eveningSlots.length),
            style: context.bold14TextMain,
          ),
          const HeightSpace(12),
          _buildSlotsWrap(context, state.eveningSlots, state.selectedTimeSlot),
        ],
      ],
    );
  }

  Widget _buildSlotsWrap(
    BuildContext context,
    List<TimeSlotModel> slots,
    TimeSlotModel? selectedTimeSlot,
  ) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: slots.map((slot) {
        final isSelected = selectedTimeSlot?.dateTime == slot.dateTime;
        return InkWell(
          onTap: () {
            context.read<SelectTimeDateBloc>().add(SelectTimeSlotEvent(slot));
          },
          borderRadius: BorderRadius.circular(6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              slot.formattedTime,
              style: isSelected
                  ? context.regular12White
                  : context.regular12Primary,
            ),
          ),
        );
      }).toList(),
    );
  }
}

Widget _buildNoSlotsView(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Text(
        t.noSlotsAvailable,
        style: context.regular14TextSub,
      ),
    ),
  );
}
