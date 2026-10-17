import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_bloc.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_event.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_state.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularDoctorCardWidget extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback? onTap;

  const PopularDoctorCardWidget({
    super.key,
    required this.doctor,
    this.onTap,
  });

  // Stable rating and views based on doctor information
  double get _rating {
    final hash = (doctor.name + (doctor.id ?? '')).hashCode.abs();
    final value = 2.0 + (hash % 29) / 10.0;
    return double.parse(value.toStringAsFixed(1));
  }

  int get _viewsCount {
    final hash = ((doctor.id ?? '') + doctor.name).hashCode.abs();
    return 2000 + (hash % 1000);
  }

  int get _filledStarsCount {
    final rounded = _rating.round();
    return rounded.clamp(1, 5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.titleColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Doctor Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 82,
                    height: 82,
                    color: AppColors.mintBackground,
                    child: doctor.profileImageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: doctor.profileImageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                              size: 40,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                            size: 40,
                          ),
                  ),
                ),
                const SizedBox(width: 12),

                // Doctor Info & Stats
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Favorite Heart
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              doctor.name,
                              style: context.bold16Secondary,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          BlocBuilder<FavoritesBloc, FavoritesState>(
                            builder: (context, favState) {
                              final isFavorite = doctor.id != null &&
                                  favState.favoriteDoctorIds.contains(doctor.id);
                              return IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite
                                      ? AppColors.red
                                      : AppColors.inactiveIconColor,
                                  size: 20,
                                ),
                                onPressed: () {
                                  context.read<FavoritesBloc>().add(
                                        ToggleFavoriteDoctorEvent(doctor),
                                      );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Specialty
                      Text(
                        DoctorSpecialty.fromKey(doctor.specialty).displayName,
                        style: context.regular12TextSub,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Rating Stars, Rating Number, Views Count
                      Row(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              final isFilled = index < _filledStarsCount;
                              return Icon(
                                Icons.star_rounded,
                                color: isFilled
                                    ? AppColors.yellow
                                    : AppColors.inactiveBorderColor,
                                size: 14,
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _rating.toStringAsFixed(1),
                            style: context.bold12Secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            t.viewsCount(count: _viewsCount.toString()),
                            style: context.regular11TextSub,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef DoctorCardWidget = PopularDoctorCardWidget;
