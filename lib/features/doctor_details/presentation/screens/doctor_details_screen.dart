import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/doctor_details/presentation/widgets/doctor_details_card_widget.dart';
import 'package:doctor_hunt_app/features/doctor_details/presentation/widgets/number_statistics_widget.dart';
import 'package:doctor_hunt_app/features/doctor_details/presentation/widgets/services_section_details.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DoctorDetailsScreen extends StatefulWidget {
  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopLeftShadowWidget(),
          BottomRightShadowWidget(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                children: [
                  CustomAppBarWidget(
                    showSearchIcon: true,
                    title: 'Doctor Details',
                  ),
                  HeightSpace(30),
                  DoctorDetailsCardWidget(
                    onBookNowPressed: () {
                      // Handle the "Book Now" button press here
                    },
                  ),
                  //doctor card
                  HeightSpace(24),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NumberStatisticsWidget(number: "100", label: "Runing"),
                        NumberStatisticsWidget(number: "500", label: "Ongoing"),
                        NumberStatisticsWidget(number: "700", label: "Patient"),
                      ],
                    ),
                  ),
                  HeightSpace(30),

                  DoctorServicesSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
