import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class FavoriteCardWidget extends StatelessWidget {
  final String imagePath;
  final String doctorName;
  final String specialty;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const FavoriteCardWidget({
    super.key,
    required this.imagePath,
    required this.doctorName,
    required this.specialty,
    this.isFavorite = true,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage = imagePath.startsWith('http://') || imagePath.startsWith('https://');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onFavoriteTap,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? AppColors.red
                        : AppColors.inactiveIconColor,
                  ),
                ),
              ),
              Container(
                height: 84,
                width: 84,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: isNetworkImage
                      ? CachedNetworkImage(
                          imageUrl: imagePath,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.person,
                            color: AppColors.subtitleColor,
                            size: 40,
                          ),
                        )
                      : Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              HeightSpace(11),
              Text(
                doctorName,
                style: context.regular16TextMain,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              HeightSpace(4),
              Text(
                specialty,
                style: context.regular12Primary,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
