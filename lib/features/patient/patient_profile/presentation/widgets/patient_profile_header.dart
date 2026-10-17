import 'dart:io';
import 'package:flutter/material.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class PatientProfileHeader extends StatelessWidget {
  final File? pickedImage;
  final String? imageUrl;
  final String name;
  final VoidCallback onPickImageTap;
  final VoidCallback onBackTap;

  const PatientProfileHeader({
    super.key,
    this.pickedImage,
    this.imageUrl,
    required this.name,
    required this.onPickImageTap,
    required this.onBackTap,
  });

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'U';
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

  Widget _buildAvatarContent(BuildContext context) {
    if (pickedImage != null) {
      return Image.file(
        pickedImage!,
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        width: 130,
        height: 130,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildInitials(context),
      );
    }

    return _buildInitials(context);
  }

  Widget _buildInitials(BuildContext context) {
    return Center(
      child: Text(
        _getInitials(name),
        style: context.bold32Primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onBackTap,
                    child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 14,
                        color: AppColors.subtitleColor,
                      ),
                    ),
                  ),
                  const WidthSpace(16),
                  Text(
                    t.profile,
                    style: context.bold18White,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 28),
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: onPickImageTap,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.mintBackground,
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.35),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: _buildAvatarContent(context),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: onPickImageTap,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFF677294),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 2.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
