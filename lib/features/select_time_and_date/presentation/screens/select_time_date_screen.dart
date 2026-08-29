import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/select_time_and_date/presentation/widgets/selected_doctor_info_card.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class SelectTimeDateScreen extends StatefulWidget {
  const SelectTimeDateScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SelectTimeDateScreen();
}

class _SelectTimeDateScreen extends State<SelectTimeDateScreen> {
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
