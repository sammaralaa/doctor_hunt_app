import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/cateory_card.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/custom_home_top_header.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/feature_doctor_card.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/live_docotor_widget.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/popular_doctor_card_widget.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  late TextEditingController? searchController;
  late String userName ;

  @override
  initState() {
    super.initState();
    searchController = TextEditingController();
    final user = FirebaseAuth.instance.currentUser;
    userName = user?.displayName ?? t.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomHomeTopHeader(searchController: searchController,userName: userName,),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeightSpace(32),
                  Text(t.liveDoctors, style: context.bold18TextMain),

                  HeightSpace(21),
                  SizedBox(
                    height: 168.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 12.w),
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
                              size: 12.r,
                              color: AppColors.subtitleColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(22),
                  SizedBox(
                    height: 265.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 12.w),
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
                              size: 12.r,
                              color: AppColors.subtitleColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(22),
                  SizedBox(
                    height: 150.h,

                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 12.w),
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
    );
  }
}
