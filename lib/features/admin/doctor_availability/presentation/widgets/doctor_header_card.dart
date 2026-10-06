import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DoctorHeaderCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorHeaderCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: doctor.profileImageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: doctor.profileImageUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 56,
                      height: 56,
                      color: AppColors.inactiveBorderColor,
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 56,
                      height: 56,
                      color: AppColors.inactiveBorderColor,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.inactiveIconColor,
                        size: 30,
                      ),
                    ),
                  )
                : Container(
                    width: 56,
                    height: 56,
                    color: AppColors.inactiveBorderColor,
                    child: const Icon(
                      Icons.person,
                      color: AppColors.inactiveIconColor,
                      size: 30,
                    ),
                  ),
          ),
          const WidthSpace(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  doctor.name,
                  style: context.bold16TextMain,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const HeightSpace(4),
                Text(
                  '${doctor.specialty} • ${t.centralClinic}',
                  style: context.regular12TextSub,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const WidthSpace(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: doctor.isActive
                  ? AppColors.primaryColor.withValues(alpha: 0.12)
                  : AppColors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  color: doctor.isActive
                      ? AppColors.primaryColor
                      : AppColors.red,
                  size: 8,
                ),
                const WidthSpace(5),
                Text(
                  doctor.isActive ? t.active : t.inactive,
                  style: doctor.isActive
                      ? context.bold11Primary
                      : context.bold11Warning,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
