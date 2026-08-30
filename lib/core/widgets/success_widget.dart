import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      constraints: BoxConstraints(maxHeight: 600),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsetsGeometry.all(40),
              decoration: BoxDecoration(
                color: AppColors.mintBackground,
                borderRadius: BorderRadius.circular(80),
              ),
              child: SvgPicture.asset(
                IconsAssets.likeIcon,
                width: 70,
                height: 70,
                color: AppColors.primaryColor,
              ),
            ),
            HeightSpace(12),
            Text("Thank You !", style: context.bold36TextMain),
            HeightSpace(5),
            Text(
              "Your Appointment Successful",
              style: context.regular18TextSub,
              textAlign: TextAlign.center,
            ),
            HeightSpace(25),
            Text(
              "You booked an appointment with Dr. Pediatrician Purpieson on February 21, at 02:00 PM",
              style: context.regular14TextSub,
              textAlign: TextAlign.center,
            ),
            HeightSpace(30),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text("Done", style: context.bold18White),
              ),
            ),
            HeightSpace(5),
            TextButton(
              onPressed: () {},
              child: Text(
                "Edit your appointment",
                style: context.regular14TextSub,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
