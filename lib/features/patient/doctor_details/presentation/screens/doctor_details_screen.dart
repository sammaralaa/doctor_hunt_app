import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_bloc.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_event.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_state.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/controller/doctor_details_bloc.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/controller/doctor_details_event.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/controller/doctor_details_state.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/widgets/doctor_details_card_widget.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/widgets/services_section_details.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final String doctorId;
  const DoctorDetailsScreen({super.key, required this.doctorId});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorDetailsBloc>().add(
      FetchDoctorDetailsEvent(doctorId: widget.doctorId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          TopLeftShadowWidget(),
          BottomRightShadowWidget(),
          BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
            builder: (context, state) {
              if (state is DoctorDetailsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is DoctorDetailsSuccessState) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),

                    child: Column(
                      children: [
                        CustomAppBarWidget(
                          showSearchIcon: true,
                          title: t.doctorDetails,
                        ),
                        HeightSpace(30),
                        BlocBuilder<FavoritesBloc, FavoritesState>(
                          bloc: getIt<FavoritesBloc>(),
                          builder: (context, favState) {
                            final isFav = getIt<FavoritesBloc>().isDoctorFavorite(
                              state.doctorData.id,
                            );

                            return DoctorDetailsCardWidget(
                              name: state.doctorData.name,
                              specialty: DoctorSpecialty.fromKey(
                                state.doctorData.specialty,
                              ).displayName,
                              imageUrl: state.doctorData.profileImageUrl,
                              isFavorite: isFav,
                              onFavoritePressed: () {
                                getIt<FavoritesBloc>().add(
                                  ToggleFavoriteDoctorEvent(state.doctorData),
                                );
                              },
                              onBookNowPressed: () {
                                SelectTimeRoute().push(context);
                              },
                            );
                          },
                        ),
                        //doctor card
                        HeightSpace(24),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildNumberStatisticItem(
                                number: "100",
                                label: t.runing,
                              ),
                              buildNumberStatisticItem(
                                number: "500",
                                label: t.ongoing,
                              ),
                              buildNumberStatisticItem(
                                number: "700",
                                label: t.patient,
                              ),
                            ],
                          ),
                        ),
                        HeightSpace(30),

                        DoctorServicesSection(),

                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: BoxBorder.all(
                              color: AppColors.white,
                              width: 9,
                            ),
                          ),
                          child: FlutterMap(
                            options: const MapOptions(
                              initialCenter: LatLng(30.0444, 31.2357),
                              initialZoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                userAgentPackageName: "doctor_hunt_app.app",
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
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget buildNumberStatisticItem({
    required String number,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.subtitleColor.withValues(alpha: 0.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(number, style: context.bold18TextMain),
          Text(label, style: context.regular14TextSub),
        ],
      ),
    );
  }
}
