import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/success_widget.dart';
import 'package:doctor_hunt_app/features/select_time_and_date/data/date_slot_model.dart';
import 'package:doctor_hunt_app/features/select_time_and_date/presentation/widgets/selected_doctor_info_card.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class SelectTimeDateScreen extends StatefulWidget {
  const SelectTimeDateScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SelectTimeDateScreen();
}

class _SelectTimeDateScreen extends State<SelectTimeDateScreen> {
  late int selectedDayIndex;
  TimeSlotModel? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    selectedDayIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentDay = dummyDays[selectedDayIndex];
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: Column(
          children: [
            CustomAppBarWidget(title: t.selectTime, showSearchIcon: false),
            HeightSpace(30),
            SelectedDoctorInfoCard(
              name: "Dr. Shruti Kedia",
              location: "Upasana Dental Clinic, salt lake",
              rating: 3,
              onBookNowPressed: () {},
            ),

            HeightSpace(23),
            SizedBox(
              height: 65,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dummyDays.length,
                separatorBuilder: (_, __) => SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final day = dummyDays[index];
                  final isSelected = selectedDayIndex == index;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                        selectedTimeSlot = null;
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
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
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day.dayLabel,
                            style: isSelected
                                ? context.regular16White
                                : context.regular16TextMain,
                          ),
                          SizedBox(height: 4),
                          Text(
                            day.availabilityText,
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
            ),
            HeightSpace(20),
            if (currentDay.timeSlots.isEmpty)
              _buildNoSlotsView(
                context,
                dummyDays[selectedDayIndex + 1].dayLabel,
              )
            else
              _buildAvailableSlotsView(dummyDays[selectedDayIndex].timeSlots),
          ],
        ),
      ),
    );
  }

  //Slots Available
  Widget _buildAvailableSlotsView(List<TimeSlotModel> slots) {
    final afternoonSlots = slots.where((s) => s.isAfternoon).toList();
    final eveningSlots = slots.where((s) => !s.isAfternoon).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (afternoonSlots.isNotEmpty) ...[
          Text(
            t.afternoonSlots(length: afternoonSlots.length),
            style: context.bold14TextMain,
          ),
          HeightSpace(12),
          _buildSlotsWrap(afternoonSlots),
          HeightSpace(20),
        ],
        if (eveningSlots.isNotEmpty) ...[
          Text(
            t.eveningSlots(length: eveningSlots.length),
            style: context.bold14TextMain,
          ),
          HeightSpace(12),
          _buildSlotsWrap(eveningSlots),
        ],
      ],
    );
  }

  Widget _buildSlotsWrap(List<TimeSlotModel> slots) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: slots.map((slot) {
        final isSelected = selectedTimeSlot == slot;
        return InkWell(
          onTap: () {
            setState(() {
              selectedTimeSlot = slot;
            });
          },
          borderRadius: BorderRadius.circular(6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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

Widget _buildNoSlotsView(BuildContext context, String nextAvailable) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(t.noSlotsAvailable, style: context.regular14TextSub),
      HeightSpace(20),
      CustomElevatdButton(
        buttonTXT: t.nextAvailabilityOn(nextAvailable: nextAvailable),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) => SuccessWidget(),
          );
        },
        buttonWidth: double.infinity,
      ),
      HeightSpace(14),
      Text(t.or, style: context.regular14TextSub),
      HeightSpace(14),
      SizedBox(
        width: double.infinity,
        height: 54,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: const BorderSide(color: AppColors.primaryColor),
          ),
          child: Text(t.contactClinic, style: context.bold18Primary),
        ),
      ),
    ],
  );
}
