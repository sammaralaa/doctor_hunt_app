import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessWidget extends StatelessWidget {
  final String doctorName;
  final String date;
  final String time;

  const SuccessWidget({
    super.key,
    required this.doctorName,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      constraints: const BoxConstraints(maxHeight: 600),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: AppColors.mintBackground,
                borderRadius: BorderRadius.circular(80),
              ),
              child: SvgPicture.asset(
                IconsAssets.likeIcon,
                width: 70,
                height: 70,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const HeightSpace(12),
            Text(t.thankYou, style: context.bold36TextMain),
            const HeightSpace(5),
            Text(
              t.appointmentSuccessful,
              style: context.regular18TextSub,
              textAlign: TextAlign.center,
            ),
            const HeightSpace(25),
            Text(
              t.appointmentBookedDetails(
                doctorName: doctorName,
                date: date,
                time: time,
              ),
              style: context.regular14TextSub,
              textAlign: TextAlign.center,
            ),
            const HeightSpace(30),
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
                child: Text(t.done, style: context.bold18White),
              ),
            ),
            const HeightSpace(5),
            // TextButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: Text(
            //     t.editYourAppointment,
            //     style: context.regular14TextSub,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
