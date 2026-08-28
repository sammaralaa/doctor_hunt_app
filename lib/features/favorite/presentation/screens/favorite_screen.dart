import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_search_text_field_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/favorite/presentation/widgets/favorite_card_widget.dart';
import 'package:doctor_hunt_app/features/home/presentation/widgets/feature_doctor_card.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteScreen();
  }
}

class _FavoriteScreen extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomAppBarWidget(
                  showSearchIcon: false,
                  title: "Favourite Doctors",
                ),
                HeightSpace(30),
                CustomSearchTextFieldWidget(onSubmit: (value) {}),
                HeightSpace(24),
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return FavoriteCardWidget(
                imagePath: ImageAssets.doctorImage2,
                doctorName: "Dr. Christenfeld N",
                specialty: "Specalist Cancer",
                initialIsFavorite: false,
              );
            }, childCount: 4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.78,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                HeightSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(t.featureDoctor, style: context.bold18TextMain),
                    TextButton.icon(
                      onPressed: () {},
                      label: Text(t.seeAll, style: context.regular12TextSub),
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.subtitleColor,
                      ),
                      iconAlignment: IconAlignment.end,
                    ),
                  ],
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: FeatureDoctorCard(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
