import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/doctor_details/presentation/widgets/custom_search_text_field_widget.dart';
import 'package:doctor_hunt_app/features/search/presentation/widgets/doctor_search_card_widget.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:flutter/material.dart';

class FindDoctorsScreen extends StatefulWidget {
  @override
  State<FindDoctorsScreen> createState() => _FindDoctorsScreenState();
}

class _FindDoctorsScreenState extends State<FindDoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Find Doctors', style: AppTextStyles.homeSectionsTitle),
      // ),
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
                    showSearchIcon: false,
                    title: 'Find Doctors',
                  ),
                  HeightSpace(24),
                  CustomSearchTextFieldWidget(onSubmit: (String value) {}),
                  HeightSpace(24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DoctorSearchCardWidget(
                            onBookNowPressed: () {},
                            CardOnTap: () {
                              DoctorDetailsRoute().push(context);
                            },
                          ),
                        );
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
}
