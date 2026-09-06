import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_search_text_field_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/doctors_list/presentation/widgets/doctor_list_card.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DoctorsListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoctorsListScreen();
}

class _DoctorsListScreen extends State<DoctorsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.doctors, style: context.regular18White),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add doctor button press
        },
        backgroundColor: AppColors.primaryColor,
        child: Row(
          children: [
            Icon(Icons.add),
            Text(t.addDoctor, style: context.regular14White),
          ],
        ),
      ),
      body: Stack(
        children: [
          TopLeftShadowWidget(),
          BottomRightShadowWidget(),
          SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchTextFieldWidget(onSubmit: (value) {}),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.filter_alt, color: AppColors.white),
                        onPressed: () {
                          // Handle filter button press
                        },
                      ),
                    ),
                  ],
                ),
                HeightSpace(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _doctorNumbers("Total Doctors", "12"),
                    SizedBox(
                      width: 2,
                      height: 50,
                      child: VerticalDivider(
                        color: AppColors.inactiveBorderColor,
                        thickness: 1,
                      ),
                    ),
                    _doctorNumbers("Active", "10"),
                  ],
                ),
                HeightSpace(16),
                DoctorsListCard(
                  name: "Dr. John Doe",
                  specialization: "Cardiologist",
                  isActive: false,
                  onBookNowPressed: () {
                    // Handle book now button press
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _doctorNumbers(String title, String number) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.primaryColorLight.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(Icons.person_outline, color: AppColors.primaryColor),
        ),
        Column(
          children: [
            Text(title, style: context.regular14TextSub),
            HeightSpace(4),
            Text(number, style: context.bold14Primary),
          ],
        ),
      ],
    );
  }
}
