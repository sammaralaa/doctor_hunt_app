import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/doctor_details/presentation/widgets/doctor_details_card_widget.dart';
import 'package:doctor_hunt_app/features/doctor_details/presentation/widgets/number_statistics_widget.dart';
import 'package:doctor_hunt_app/features/doctor_details/presentation/widgets/services_section_details.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),

              child: Column(
                children: [
                  CustomAppBarWidget(
                    showSearchIcon: true,
                    title: t.doctorDetails,
                  ),
                  HeightSpace(30),
                  DoctorDetailsCardWidget(
                    onBookNowPressed: () {
                      //Book Now
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

                  Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: BoxBorder.all(color: AppColors.white, width: 9.w),
                    ),
                    child: FlutterMap(
                      options: const MapOptions(
                        initialCenter: LatLng(30.0444, 31.2357),
                        initialZoom: 13.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: t.urlTemp,
                          userAgentPackageName: t.packageName,
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: const LatLng(30.0444, 31.2357),
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_on,
                                color: AppColors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
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
