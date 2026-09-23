import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class PopularDoctorCardWidget extends StatelessWidget {
  final DoctorModel doctorData;
  const PopularDoctorCardWidget({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(10),
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
            CachedNetworkImage(
              imageUrl: doctorData.profileImageUrl,
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ),

            HeightSpace(14),
            Text(doctorData.name, style: context.bold18TextMain),
            Text(doctorData.specialty, style: context.regular14TextSub),
            HeightSpace(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star_rounded,
                  color: index < 4 ? AppColors.yellow : AppColors.white,
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
