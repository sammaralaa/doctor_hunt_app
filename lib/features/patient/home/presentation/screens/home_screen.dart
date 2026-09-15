import 'dart:io';

import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/patient/home/data/repos/home_repository.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  late TextEditingController? searchController;
  late String userName;

  @override
  initState() {
    super.initState();
    searchController = TextEditingController();
    final user = FirebaseAuth.instance.currentUser;
    userName = user?.displayName ?? t.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is ProfileImageSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile picture updated successfully!')),
                  );
                } else if (state is ProfileImageFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
                },
                builder: (context, state) {
                  String? currentProfileImage;
                bool isLoading = false;

                if (state is ProfileImageLoadingState) {
                  isLoading = true;
                } else if (state is ProfileImageSuccessState) {
                  currentProfileImage = state.imageUrl;
                }
                  return CustomHomeTopHeader(
                    isLoading : isLoading,
                    searchController: searchController,
                    userName: userName,
                    profileImageUrl: currentProfileImage,
                    onProfileImageTap: () async{
                      final File? pickedFile = await HomeRepository.pickProfileImage();
                      if (pickedFile != null) {
                        context.read<HomeBloc>().add(UploadProfileImageEvent(pickedFile));
                      }
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
                    SizedBox(
                      height: 265,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return PopularDoctorCardWidget();
                        },
                      ),
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
