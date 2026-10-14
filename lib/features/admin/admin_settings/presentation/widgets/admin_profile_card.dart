import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class AdminProfileCard extends StatelessWidget {
  final String? name;
  final String? email;
  final String? imageUrl;
  final String? imageAsset;
  final VoidCallback? onTap;

  const AdminProfileCard({
    super.key,
    this.name,
    this.email,
    this.imageUrl,
    this.imageAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: AppColors.mintBackground,
                    child: _buildAvatarImage(),
                  ),
                ),
                const WidthSpace(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name ?? t.administrator,
                        style: context.bold18TextMain,
                      ),
                      const HeightSpace(6),
                      Text(
                        email ?? t.adminEmail,
                        style: context.regular14TextSub,
                        overflow: TextOverflow.ellipsis,
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

  Widget _buildAvatarImage() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _fallbackImage(),
      );
    }
    return Image.asset(
      imageAsset ?? ImageAssets.doctorImage,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => _fallbackImage(),
    );
  }

  Widget _fallbackImage() {
    return const Icon(
      Icons.person,
      color: AppColors.primaryColor,
      size: 32,
    );
  }
}
