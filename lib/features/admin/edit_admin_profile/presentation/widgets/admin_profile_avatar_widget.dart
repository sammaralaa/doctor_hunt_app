import 'dart:io';
import 'package:flutter/material.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class AdminProfileAvatarWidget extends StatelessWidget {
  final File? pickedImage;
  final String? imageUrl;
  final String name;
  final VoidCallback onTap;

  const AdminProfileAvatarWidget({
    super.key,
    this.pickedImage,
    this.imageUrl,
    required this.name,
    required this.onTap,
  });

  String _getInitials(String name) {
    final trimmed = name.trim();
    //if (trimmed.isEmpty) return 'AK';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      final first = parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '';
      final second = parts[1].isNotEmpty ? parts[1][0].toUpperCase() : '';
      final initials = '$first$second';
      return initials.isNotEmpty ? initials : 'AK';
    }
    return trimmed.length >= 2
        ? trimmed.substring(0, 2).toUpperCase()
        : trimmed.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mintBackground,
                  border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: ClipOval(child: _buildAvatarContent(context)),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2.5),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        const HeightSpace(12),
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.photo_camera_outlined,
                color: AppColors.primaryColor,
                size: 16,
              ),
              const WidthSpace(6),
              Text(t.tapPhotoToChange, style: context.medium12Primary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarContent(BuildContext context) {
    if (pickedImage != null) {
      return Image.file(
        pickedImage!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildInitials(context),
      );
    }

    return _buildInitials(context);
  }

  Widget _buildInitials(BuildContext context) {
    return Center(
      child: Text(_getInitials(name), style: context.bold32Primary),
    );
  }
}
