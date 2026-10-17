import 'dart:developer';

import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_bloc.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_event.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_bloc.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_event.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_state.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/widgets/popular_doctor_card_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularDoctorsScreen extends StatelessWidget {
  const PopularDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hasPopular = _hasBloc<PopularDoctorsBloc>(context);
    final hasFavorites = _hasBloc<FavoritesBloc>(context);

    if (hasPopular && hasFavorites) {
      return const PopularDoctorsView();
    }

    return MultiBlocProvider(
      providers: [
        if (!hasPopular)
          BlocProvider<PopularDoctorsBloc>(
            create: (context) =>
                getIt<PopularDoctorsBloc>()
                  ..add(const FetchPopularDoctorsEvent()),
          ),
        if (!hasFavorites)
          BlocProvider<FavoritesBloc>.value(
            value: getIt<FavoritesBloc>()
              ..add(const FetchFavoriteDoctorsEvent()),
          ),
      ],
      child: const PopularDoctorsView(),
    );
  }

  static bool _hasBloc<T extends StateStreamableSource<Object?>>(
    BuildContext context,
  ) {
    try {
      context.read<T>();
      return true;
    } catch (_) {
      return false;
    }
  }
}

class PopularDoctorsView extends StatelessWidget {
  const PopularDoctorsView({super.key});

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
                    title: t.popularDoctors,
                  ),
                  const HeightSpace(20),
                  Expanded(
                    child: BlocBuilder<PopularDoctorsBloc, PopularDoctorsState>(
                      builder: (context, state) {
                        if (state is PopularDoctorsLoadingState ||
                            state is PopularDoctorsInitialState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          );
                        }

                        if (state is PopularDoctorsErrorState) {
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
                                    context.read<PopularDoctorsBloc>().add(
                                      const FetchPopularDoctorsEvent(),
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

                        if (state is PopularDoctorsLoadedState) {
                          if (state.doctors.isEmpty) {
                            return Center(
                              child: Text(
                                t.noPopularDoctorsFound,
                                style: context.regular14TextSub,
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.only(bottom: 20),
                            itemCount: state.doctors.length,
                            itemBuilder: (context, index) {
                              final doctor = state.doctors[index];
                              log(state.doctors.length.toString());
                              return DoctorCardWidget(
                                doctor: doctor,
                                onTap: () {
                                  DoctorDetailsRoute(
                                    doctorId: doctor.id ?? '',
                                  ).push(context);
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
}
