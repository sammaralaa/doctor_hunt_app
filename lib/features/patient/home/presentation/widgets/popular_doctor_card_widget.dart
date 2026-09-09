import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class PopularDoctorCardWidget extends StatelessWidget {
  const PopularDoctorCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Handle card tap
          DoctorDetailsRoute().push(context);
        },
        child: Column(
          children: [
            Image.asset(
              ImageAssets.doctorImage2,
              // width: 120,
              // height: 120,
              fit: BoxFit.cover,
            ),
            HeightSpace(14),
            Text(
              'Dr. Fillerup Grab',
              style: context.bold18TextMain,
            ),
            Text('Medicine Specialist', style: context.regular14TextSub),
            HeightSpace(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star_rounded,
                  color: index < 4
                      ? AppColors.yellow 
                      : AppColors.white, 
                  size: 12,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
