import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_bloc.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_event.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_state.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/cateory_card.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/custom_home_top_header.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/feature_doctor_card.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/live_docotor_widget.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/popular_doctor_card_widget.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  late TextEditingController? searchController;

  @override
  initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()
        ..add(GetUserProfileDataEvent())
        ..add(FetchDoctorsDataEvent()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  String? currentProfileImage;
                  String userName = "";
                  if (state is UserProfileSuccessState) {
                    currentProfileImage = state.user.profileImage;
                    userName = state.user.name;
                  }

                  return CustomHomeTopHeader(
                    isLoading: state is UserProfileLoadingState,
                    searchController: searchController,
                    userName: userName,
                    profileImageUrl: currentProfileImage,
                    onProfileImageTap: () {},
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(32),
                    Text(t.liveDoctors, style: context.bold18TextMain),

                    HeightSpace(21),
                    SizedBox(
                      height: 168,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return LiveDocotorWidget();
                        },
                      ),
                    ),
                    HeightSpace(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CategoryCard(iconPath: IconsAssets.category1),
                        CategoryCard(
                          iconPath: IconsAssets.categoryHeart,
                          fromColor: AppColors.primaryColor,
                          toColor: AppColors.primaryColorLight,
                        ),
                        CategoryCard(
                          iconPath: IconsAssets.categoryEye,
                          fromColor: AppColors.categoryColorOrangeFrom,
                          toColor: AppColors.categoryColorOrangeTo,
                        ),
                        CategoryCard(
                          iconPath: IconsAssets.categoryFit,
                          fromColor: AppColors.categoryColorRedFrom,
                          toColor: AppColors.categoryColorRedTo,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.popularDoctors, style: context.bold18TextMain),
                        TextButton(
                          onPressed: () {
                            // Handle "See All" button press
                          },
                          child: Row(
                            children: [
                              Text(t.seeAll, style: context.regular12TextSub),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: AppColors.subtitleColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(22),
                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) {
                        return current is FetchDoctorsLoadingState ||
                            current is FetchDoctorsSuccessState ||
                            current is FetchDoctorsFailureState;
                      },
                      builder: (context, state) {
                        if (state is FetchDoctorsLoadingState) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header: Popular Doctor & See all
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 120,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 14,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Horizontal List of Doctor Cards
                                SizedBox(
                                  height: 250,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 3,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 14),
                                    itemBuilder: (context, index) {
                                      //return _buildDoctorCardSkeleton();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (state is FetchDoctorsFailureState) {}
                        if (state is FetchDoctorsSuccessState) {
                          final doctors = state.doctorsData;
                          return SizedBox(
                            height: 265,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: doctors.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return PopularDoctorCardWidget(
                                  doctorData: doctors[index],
                                );
                              },
                            ),
                          );
                        }
                        return SizedBox(
                          height: 265,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              // return PopularDoctorCardWidget();
                            },
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.featureDoctor, style: context.bold18TextMain),
                        TextButton(
                          onPressed: () {
                            // Handle "See All" button press
                          },
                          child: Row(
                            children: [
                              Text(t.seeAll, style: context.regular12TextSub),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: AppColors.subtitleColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(22),
                    SizedBox(
                      height: 150,

                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return FeatureDoctorCard();
                        },
                      ),
                    ),
                    HeightSpace(100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
