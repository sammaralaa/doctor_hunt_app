import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsPatientCard extends StatelessWidget {
  final String patientName;
  final String? patientImage;
  final String? patientEmail;

  const AppointmentDetailsPatientCard({
    super.key,
    required this.patientName,
    this.patientImage,
    this.patientEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.patient,
          style: context.bold16Secondary,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.titleColor.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 58,
                  height: 58,
                  color: AppColors.mintBackground,
                  child: patientImage != null && patientImage!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: patientImage!,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: context.bold16Secondary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.mail_outline_rounded,
                          size: 16,
                          color: AppColors.subtitleColor,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            patientEmail ?? '',
                            style: context.regular12TextSub,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
