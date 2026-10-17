import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class AppProfileCard extends StatelessWidget {
  final String? name;
  final String? email;
  final String? imageUrl;
  final String? imageAsset;
  final VoidCallback? onTap;
  final String? defaultName;
  final String? defaultEmail;

  const AppProfileCard({
    super.key,
    this.name,
    this.email,
    this.imageUrl,
    this.imageAsset,
    this.onTap,
    this.defaultName,
    this.defaultEmail,
  });

  String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return 'U';
    final trimmed = name.trim();
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      final first = parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '';
      final second = parts[1].isNotEmpty ? parts[1][0].toUpperCase() : '';
      final initials = '$first$second';
      return initials.isNotEmpty ? initials : 'U';
    }
    return trimmed.length >= 2
        ? trimmed.substring(0, 2).toUpperCase()
        : trimmed.toUpperCase();
  }

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
                    child: _buildAvatarImage(context),
                  ),
                ),
                const WidthSpace(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (name != null && name!.trim().isNotEmpty)
                            ? name!
                            : (defaultName ?? t.patientUser),
                        style: context.bold18TextMain,
                      ),
                      const HeightSpace(6),
                      Text(
                        (email != null && email!.trim().isNotEmpty)
                            ? email!
                            : (defaultEmail ?? t.adminEmail),
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

  Widget _buildAvatarImage(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _fallbackInitials(context),
      );
    }
    if (imageAsset != null && imageAsset!.isNotEmpty) {
      return Image.asset(
        imageAsset!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _fallbackInitials(context),
      );
    }
    return _fallbackInitials(context);
  }

  Widget _fallbackInitials(BuildContext context) {
    final effectiveName = (name != null && name!.trim().isNotEmpty)
        ? name
        : (defaultName ?? 'User');
    return Center(
      child: Text(
        _getInitials(effectiveName),
        style: context.bold20Primary,
      ),
    );
  }
}
