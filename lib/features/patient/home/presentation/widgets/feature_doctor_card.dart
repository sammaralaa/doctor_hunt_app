import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_bloc.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_event.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_state.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeatureDoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback? onTap;

  const FeatureDoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
  });

  double get _rating {
    final hash = (doctor.name + (doctor.id ?? '')).hashCode.abs();
    final value = 3.5 + (hash % 15) / 10.0;
    return double.parse(value.toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.titleColor.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<FavoritesBloc, FavoritesState>(
                  bloc: getIt<FavoritesBloc>(),
                  builder: (context, favState) {
                    final isFav =
                        getIt<FavoritesBloc>().isDoctorFavorite(doctor.id);
                    return GestureDetector(
                      onTap: () {
                        getIt<FavoritesBloc>().add(
                          ToggleFavoriteDoctorEvent(doctor),
                        );
                      },
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav
                            ? AppColors.red
                            : AppColors.inactiveIconColor,
                        size: 14,
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: AppColors.yellow, size: 10),
                    const SizedBox(width: 2),
                    Text(
                      _rating.toStringAsFixed(1),
                      style: context.bold8TextMain,
                    ),
                  ],
                ),
              ],
            ),
            const HeightSpace(6),
            ClipRRect(
              borderRadius: BorderRadius.circular(27.5),
              child: doctor.profileImageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: doctor.profileImageUrl,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => Image.asset(
                        ImageAssets.onBoarding5,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      ImageAssets.onBoarding5,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
            ),
            const HeightSpace(6),
            Text(
              doctor.name,
              style: context.bold12TextMain,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              '\$${doctor.consultationFee.toStringAsFixed(0)}/ hours',
              style: context.regular8TextSub,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
