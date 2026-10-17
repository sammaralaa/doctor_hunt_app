import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_bloc.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_event.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_state.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/cateory_card.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/custom_home_top_header.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/feature_doctor_card.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/widgets/popular_doctor_card_widget.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/presentation/widgets/custom_animated_drawer.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_bloc.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_event.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onOpenDrawer;

  const HomeScreen({super.key, this.onOpenDrawer});

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>()
            ..add(GetUserProfileDataEvent())
            ..add(FetchDoctorsDataEvent()),
        ),
        BlocProvider<PopularDoctorsBloc>(
          create: (context) => getIt<PopularDoctorsBloc>()
            ..add(const FetchPopularDoctorsEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) {
                  return current is UserProfileLoadingState ||
                      current is UserProfileSuccessState ||
                      current is UserProfileFailureState;
                },
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
                    onSearchTap: () => const SearchRoute().push(context),
                    onProfileImageTap: widget.onOpenDrawer ??
                        () {
                          CustomAnimatedDrawerScope.of(context)?.openDrawer();
                        },
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
                    HeightSpace(60),

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
                    HeightSpace(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.popularDoctors, style: context.bold18TextMain),
                        TextButton(
                          onPressed: () {
                            const PopularDoctorsRoute().push(context);
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
                          return _doctorLoadingSkelton();
                        }
                        if (state is FetchDoctorsFailureState) {
                          return SizedBox(
                            height: 250,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: AppColors.red,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    state.errorMessage,
                                    style: context.regular14TextSub,
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton.icon(
                                    onPressed: () {
                                      context.read<HomeBloc>().add(
                                        FetchDoctorsDataEvent(),
                                      );
                                    },
                                    icon: const Icon(Icons.refresh),
                                    label: Text("Retry"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
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
                                  onCardTap: () {
                                    DoctorDetailsRoute(
                                      doctorId: doctors[index].id!,
                                    ).push(context);
                                  },
                                  doctorData: doctors[index],
                                );
                              },
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(t.featureDoctor, style: context.bold18TextMain),
                        TextButton(
                          onPressed: () {
                            const PopularDoctorsRoute().push(context);
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
                    BlocBuilder<PopularDoctorsBloc, PopularDoctorsState>(
                      builder: (context, state) {
                        if (state is PopularDoctorsLoadingState ||
                            state is PopularDoctorsInitialState) {
                          return _featureDoctorsLoadingSkeleton();
                        }
                        if (state is PopularDoctorsLoadedState) {
                          final doctors = state.doctors;
                          if (doctors.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return SizedBox(
                            height: 150,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: doctors.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final doctor = doctors[index];
                                return FeatureDoctorCard(
                                  doctor: doctor,
                                  onTap: () {
                                    if (doctor.id != null) {
                                      DoctorDetailsRoute(
                                        doctorId: doctor.id!,
                                      ).push(context);
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
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

  Widget _doctorLoadingSkelton() {
    return Shimmer.fromColors(
      baseColor: AppColors.inactiveBorderColor,
      highlightColor: AppColors.inactiveIconColor.withValues(alpha: 0.3),
      child: SizedBox(
        height: 265,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (_, _) => _doctorCardSkeleton(),
        ),
      ),
    );
  }

  Widget _featureDoctorsLoadingSkeleton() {
    return Shimmer.fromColors(
      baseColor: AppColors.inactiveBorderColor,
      highlightColor: AppColors.inactiveIconColor.withValues(alpha: 0.3),
      child: SizedBox(
        height: 150,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (_, _) => _featureDoctorCardSkeleton(),
        ),
      ),
    );
  }

  Widget _featureDoctorCardSkeleton() {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _skeletonBox(width: 14, height: 14, isCircle: true),
              _skeletonBox(width: 25, height: 10, radius: 2),
            ],
          ),
          const SizedBox(height: 8),
          _skeletonBox(width: 55, height: 55, isCircle: true),
          const SizedBox(height: 8),
          _skeletonBox(width: 65, height: 10, radius: 2),
          const SizedBox(height: 4),
          _skeletonBox(width: 45, height: 8, radius: 2),
        ],
      ),
    );
  }

  Widget _doctorCardSkeleton() {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _skeletonBox(width: 120, height: 120, radius: 8),
          const SizedBox(height: 14),
          _skeletonBox(width: 100, height: 16, radius: 4),
          const SizedBox(height: 8),
          _skeletonBox(width: 80, height: 12, radius: 4),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (_) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _skeletonBox(width: 12, height: 12, isCircle: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skeletonBox({
    required double width,
    required double height,
    double radius = 4,
    bool isCircle = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(radius),
      ),
    );
  }
}
