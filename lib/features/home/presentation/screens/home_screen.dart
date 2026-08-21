import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/cateory_card.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/custom_home_top_header.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/feature_doctor_card.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/live_docotor_widget.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/popular_doctor_card_widget.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
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

  @override
  initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: CustomHomeTopHeader(searchController: searchController),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeightSpace(32),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Live Doctors',
                    style: AppTextStyles.homeSectionsTitle,
                  ),
                ),

                HeightSpace(21),

                SizedBox(
                  height: 168.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (context, index) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      return LiveDocotorWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  HeightSpace(22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryCard(iconPath: IconsAssets.category1),
                      CategoryCard(
                        iconPath: IconsAssets.categoryHeart,
                        fromColor: Color(0xFF0EBE7E),
                        toColor: Color(0xFF07D9AD),
                      ),
                      CategoryCard(
                        iconPath: IconsAssets.categoryEye,
                        fromColor: Color(0xFFFE7F44),
                        toColor: Color(0xFFFFCF68),
                      ),
                      CategoryCard(
                        iconPath: IconsAssets.categoryFit,
                        fromColor: Color(0xFFFF484C),
                        toColor: Color(0xFFFF484C),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Doctors',
                        style: AppTextStyles.homeSectionsTitle,
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle "See All" button press
                        },
                        child: Row(
                          children: [
                            Text(
                              'See all',
                              style: AppTextStyles.subTitleTextStyle.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
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
                      //padding: EdgeInsets.symmetric(horizontal: 20.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        return PopularDoctorCardWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Feature Doctor',
                        style: AppTextStyles.homeSectionsTitle,
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle "See All" button press
                        },
                        child: Row(
                          children: [
                            Text(
                              'See all',
                              style: AppTextStyles.subTitleTextStyle.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
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
                      //padding: EdgeInsets.symmetric(horizontal: 20.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        return FeatureDoctorCard();
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
