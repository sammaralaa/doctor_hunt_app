import 'dart:developer';

import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_search_text_field_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_bloc.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_event.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_state.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/widgets/favorite_card_widget.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/feature_doctor_card.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    getIt<FavoritesBloc>().add(const FetchFavoriteDoctorsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<FavoritesBloc>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomAppBarWidget(
                      showSearchIcon: false,
                      title: t.favouriteDoctors,
                    ),
                    HeightSpace(30),
                    CustomSearchTextFieldWidget(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.trim().toLowerCase();
                        });
                      },
                      onSubmit: (value) {
                        setState(() {
                          _searchQuery = value.trim().toLowerCase();
                        });
                      },
                    ),
                    HeightSpace(24),
                  ],
                ),
              ),
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoadingState ||
                      state is FavoritesInitialState) {
                    return _buildLoadingGrid();
                  }

                  if (state is FavoritesErrorState) {
                    log("error ${state.errorMessage}");
                    return SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.red,
                              size: 48,
                            ),
                            HeightSpace(12),
                            Text(
                              state.errorMessage,
                              style: context.regular14TextSub,
                              textAlign: TextAlign.center,
                            ),
                            HeightSpace(16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                context.read<FavoritesBloc>().add(
                                  const FetchFavoriteDoctorsEvent(),
                                );
                              },
                              child: Text(
                                t.retry,
                                style: context.regular14White,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is FavoritesEmptyState) {
                    return SliverToBoxAdapter(child: _buildEmptyState());
                  }

                  if (state is FavoritesSuccessState) {
                    final List<DoctorModel> displayedDoctors =
                        _searchQuery.isEmpty
                        ? state.favoriteDoctors
                        : state.favoriteDoctors.where((doctor) {
                            final nameMatch = doctor.name
                                .toLowerCase()
                                .contains(_searchQuery);
                            final specialty = DoctorSpecialty.fromKey(
                              doctor.specialty,
                            ).displayName.toLowerCase();
                            final specialtyMatch = specialty.contains(
                              _searchQuery,
                            );
                            return nameMatch || specialtyMatch;
                          }).toList();

                    if (displayedDoctors.isEmpty) {
                      return SliverToBoxAdapter(child: _buildEmptyState());
                    }

                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final doctor = displayedDoctors[index];
                        final specialtyName = DoctorSpecialty.fromKey(
                          doctor.specialty,
                        ).displayName;

                        return FavoriteCardWidget(
                          imagePath: doctor.profileImageUrl,
                          doctorName: doctor.name,
                          specialty: specialtyName,
                          isFavorite: true,
                          onTap: () {
                            if (doctor.id != null && doctor.id!.isNotEmpty) {
                              DoctorDetailsRoute(
                                doctorId: doctor.id!,
                              ).push(context);
                            }
                          },
                          onFavoriteTap: () {
                            context.read<FavoritesBloc>().add(
                              ToggleFavoriteDoctorEvent(doctor),
                            );
                          },
                        );
                      }, childCount: displayedDoctors.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.78,
                          ),
                    );
                  }

                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 64,
            color: AppColors.inactiveIconColor,
          ),
          HeightSpace(16),
          Text(t.noFavouriteDoctors, style: context.bold16TextMain),
          HeightSpace(8),
          Text(
            t.noFavouriteDoctorsDesc,
            style: context.regular12TextSub,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.inactiveBorderColor,
          highlightColor: AppColors.inactiveIconColor,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );
      }, childCount: 4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.78,
      ),
    );
  }
}

/*
Column(
          children: [
            CustomAppBarWidget(showSearchIcon: false, title: "Favourite Doctors"),
            HeightSpace(34),
            CustomSearchTextFieldWidget(onSubmit: (value) {}),
            HeightSpace(24),
            
            FavoriteCardWidget(
              imagePath: ImageAssets.doctorImage2,
              doctorName: "Dr. Christenfeld N",
              specialty: "Specalist Cancer",
              initialIsFavorite: false,
            ),
          ],
        ),
*/
