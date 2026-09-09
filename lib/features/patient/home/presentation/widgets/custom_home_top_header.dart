
import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class CustomHomeTopHeader extends StatefulWidget {
  final TextEditingController? searchController;
  final String userName;
  //final String? profileImageUrl;
  final VoidCallback? onProfileImageTap;

  const CustomHomeTopHeader({
    super.key,
    this.searchController,
    required this.userName,
    this.onProfileImageTap,
  });

  @override
  State<CustomHomeTopHeader> createState() => _CustomHomeTopHeaderState();
}

class _CustomHomeTopHeaderState extends State<CustomHomeTopHeader> {

 

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.hi(userName: widget.userName),
                    style: context.regular20White,
                  ),
                  Text(t.findYourDoctor, style: context.bold26White),
                  HeightSpace(30),
                ],
              ),
              GestureDetector(
                onTap: widget.onProfileImageTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child:
                      // widget.profileImageUrl != null &&
                      //     widget.profileImageUrl!.isNotEmpty
                      // ? Image.network(
                      //     widget.profileImageUrl!,
                      //     width: 60,
                      //     height: 60,
                      //     fit: BoxFit.cover,
                      //     errorBuilder: (context, error, stackTrace) =>
                      //         Image.asset(
                      //           ImageAssets.onBoarding5,
                      //           width: 60,
                      //           height: 60,
                      //           fit: BoxFit.cover,
                      //         ),
                      //   )
                      // : 
                      Image.asset(
                          ImageAssets.onBoarding5,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          left: 20,
          right: 20,
          bottom: -24,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: widget.searchController,
              onSubmitted: (value) => {FindDoctorsRoute().push(context)},
              decoration: InputDecoration(
                hintText: t.search,
                hintStyle: context.regular16TextSub,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.subtitleColor,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.subtitleColor),
                  onPressed: () {
                    //searchController.clear();
                  },
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
